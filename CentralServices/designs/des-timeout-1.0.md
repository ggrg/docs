# Design Timeout DAO Layer

The purpose of this document is to explain the outcome of story [4.4 Design Timeout DAO layer and flow #303](https://github.com/mojaloop/project/issues/303). The target is to define an efficient way of creating a list of transfers to be expired by the TimeoutHandler. The solution should be proven light and able to extract randomly distributed transfers amongst large dataset, which will be continuously growing.

## Prerequisites

Before diving into the resolution of the problem, let's first describe what was used for finding and proving it, together with the required change to the DB model to cater for it.

### Random Transfers Dataset

A Node.js program was created for generating N count of transfers together with their corresponding states. M count of those transfers are such to be processed by the TimeoutHandler. The program can be found in the **central-ledger** repo [here](https://github.com/mojaloop/central-ledger/tree/develop-PI3/testPI2/util/randomTransfers). Following is the example configuration which may be used as input parameter to the main **insert** function of this module:
```js
const config = {
  debug: 5000, // how often to output progress
  totalCount: 1000000, // total number of transfers to be inserted
  expiredCount: 1000, // target number of randomly distributed expired transfers
  amount: [1, 100], // transfer amount range
  currencyList: ['USD', 'EUR', 'ZAR'], // transfer currencies list
  hoursDiff: [0, 168] // hours difference interval from current time
}
```
As a result of calling `RandomTransfer.insert(config)` we got 1M transfers in the *transfer* table and approximately 3.5M records in *transferStateChange* table. The number of expired transfers in *RECEIVED_PREPARE* or *RESERVED* state was 1000 at the time of the generation of the transfers, but this number was quickly growing as time was passing and other randomly inserted transfers' expirationDate got passed by the present time. A quick fix to that is to shift the expirationDate of all 1M transfers in table *transfer* by the interval of time that passed since data generation:
```sql
UPDATE transfer t
SET expirationDate = expirationDate + interval 1 hour;
```

### DB Model Changes

We currently don't update the transfer state, but make insert for each state change instead. As a result we have multiple records in transferStateChange table which correspond to every transfer. 

In order to get the current state of any transfer we need to select the last inserted record. When working with single transfer this is achieved with descending ordering by id and getting the first record. But when we want to do so for a million transfers we need to use *INNER JOIN* of subquery with *MAX* function applied over *GROUP BY transferId*. 

After running such query on transferStateChange table for 3.5M it resulted in nearly 60 seconds execution time (before joining the result to the other part of the query). It was clear it is not satisfactory and we couldn't scale for the future data growth. The solution we found was to proceed only the newly inserted transfer state changes. In this way the *GROUP BY* subquery won't be run over such large datasets of 3.5M, but just over the dataset of newly inserts after the previous run of the TimeoutHandler. 

Thus we need a data structure to store the value of the *MAX* transferStateChangeId we have already processed:

```sql
DROP TABLE IF EXISTS `segment`;
CREATE TABLE `segment` (
  `segmentId` int(11) NOT NULL AUTO_INCREMENT,
  `segmentType` varchar(50) NOT NULL,
  `enumeration` int(11) NOT NULL DEFAULT '0',
  `tableName` varchar(50) NOT NULL,
  `value` bigint(20) NOT NULL,
  `changedDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`segmentId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

Later on we need a data structure to store not only the transfers that need to be processed by the TimeoutHandler, but also such that may expire later if not changed to other final state (as *COMMITTED*):

```sql
DROP TABLE IF EXISTS `transferTimeout`;
CREATE TABLE `transferTimeout` (
  `transferTimeoutId` bigint(20) NOT NULL AUTO_INCREMENT,
  `transferId` varchar(36) NOT NULL,
  `expirationDate` datetime NOT NULL,
  `createdDate` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`transferTimeoutId`),
  UNIQUE KEY `transfertimeout_transferid_unique` (`transferId`),
  CONSTRAINT `transfertimeout_transferid_foreign` FOREIGN KEY (`transferId`) REFERENCES `transfer` (`transferId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

## Main Process

Following is the process that is to be implemented in central-ledger. Here it is described with anonymous SQL block and pseudo variables marked with @. Same functionality should be achieved with Node.js using knex.

1. Get last segment as `@intervalMin`
```sql
SELECT value INTO @intevalMin
FROM segment
WHERE segmentType = 'timeout'
AND enumeration = 0
AND tableName = 'transferStateChange';
```

2. If the query doesn't return a record we set the variable to 0
```sql
SET @intevalMin = IFNULL(@intevalMin, 0);
```

3. Clean up *transferTimeout* from finalised transfers
```sql
DELETE tt
FROM transferTimeout AS tt
JOIN (SELECT tsc.transferId, MAX(tsc.transferStateChangeId) maxTransferStateChangeId
      FROM transferTimeout tt1
      JOIN transferStateChange tsc
      ON tsc.transferId = tt1.transferId
      GROUP BY transferId) ts
ON ts.transferId = tt.transferId
JOIN transferStateChange tsc
ON tsc.transferStateChangeId = ts.maxTransferStateChangeId
WHERE tsc.transferStateId IN ('RECEIVED_FULFIL', 'COMMITTED', 'FAILED',
      'EXPIRED',  'EXPIRED_PREPARED', 'EXPIRED_RESERVED', 'REJECTED', 'ABORTED');
```
Another alternative to deleting records from transferTimeout table would be adding isActive BIT DEFAULT 1 column and marking it as *false* for the above *transferIds*

4. Get last *transferStateChangeId* as `@intervalMax`
```sql
SELECT MAX(transferStateChangeId) INTO @intervalMax
FROM transferStateChange;
```

5. Start a transaction - so far we've been just preparing for the main job of marking the transfers as expired by the TimeoutHandler. The code 1-5 could be run fully or separately multiple times without negative consequence, but what follows should be completed in single batch (or rolled back)
```sql
START TRANSACTION;
SET @transactionTimestamp = now()
```

6. Insert all new transfers still in processing state
```sql
INSERT INTO transferTimeout(transferId, expirationDate)
SELECT t.transferId, t.expirationDate
FROM transfer t
JOIN (SELECT transferId, MAX(transferStateChangeId) maxTransferStateChangeId
      FROM transferStateChange
      WHERE transferStateChangeId > @intervalMin
      AND transferStateChangeId <= @intervalMax
      GROUP BY transferId) ts
ON ts.transferId = t.transferId
JOIN transferStateChange tsc
ON tsc.transferStateChangeId = ts.maxTransferStateChangeId
WHERE tsc.transferStateId IN ('RECEIVED_PREPARE', 'RESERVED');
```

7. Get all transfers to be expired
```sql
SELECT tt.*
FROM transferTimeout tt
WHERE tt.expirationDate < @transactionTimestamp;
```

8. Process the list - here's actually where the TimeoutHandler logic will be implemented. It is not part of the current study which focuses on getting the list of transfers for expiration.

9. Update *segment* table to be used for the next run
```sql
IF @intervalMin = 0
  INSERT
  INTO segment(segmentType, enumeration, tableName, value)
  VALUES ('timeout', 0, 'transferStateChange', @intervalMax);
ELSE
  UPDATE segment
  SET value = @intervalMax
  WHERE segmentType = 'timeout'
  AND enumeration = 0
  AND tableName = 'transferStateChange';
```

10. Commit transaction and exit TimeoutHandler process

```sql
COMMIT;
```

## Finally

The above process 1-10 may be tested against the inserted dataset of 1M transfers by processing the first 100,000 transfer state changes. Such batch is expected to take around 1-2 seconds to complete. Then the next batch may be processed up to 200,000 and so on. Other useful SQL queries are:

- Explore data from main tables
```sql
SELECT COUNT(*), MIN(transferStateChangeId) minId, MAX(transferStateChangeId) maxId 
FROM transferStateChange;

SELECT COUNT(*) FROM transfer;
SELECT COUNT(*) FROM transferTimeout;
```

- Select transfers for expiration without intermediate structures
```sql
SELECT t.transferId, t.expirationDate, tsc.transferStateId, ts.transferStateChangeIdMax
FROM transfer t
JOIN (SELECT transferId, MAX(transferStateChangeId) transferStateChangeIdMax
      FROM transferStateChange
      GROUP BY transferId) ts
ON ts.transferId = t.transferId
JOIN transferStateChange tsc
ON tsc.transferStateChangeId = ts.transferStateChangeIdMax
WHERE tsc.transferStateId IN ('RECEIVED_PREPARE', 'RESERVED')
AND t.expirationDate < now()
LIMIT 100000;
```

- Change the state of some transfers to final
```sql
INSERT 
INTO transferStateChange(transferId, transferStateId)
SELECT transferId, 'ABORTED'
FROM transferTimeout
LIMIT 10;
```

- Change the state of all transfers to final
```sql
INSERT 
INTO transferStateChange(transferId, transferStateId)
SELECT t.transferId, 'ABORTED'
FROM transfer t
JOIN transferTimeout tt
ON tt.transferId = t.transferId
WHERE t.expirationDate < now();
```
The last two inserts might be used to test the clean-up command from Step 3.
