# Central Settlement

## Anticipated Operational Business Process

1. Collect transfers into currently OPEN settlement window(s)
1. Closing a window results in a new window being open
1. Trigger settlement event including CLOSED and/or ABORTED window(s)
1. PENDING_SETTLEMENT state initiated upon creating a settlement
1. Perform settlement transfer(s):
   1. PS_TRANSFERS_RECORDED creates the settlement transfer and places it in RECEIVED_PREPARE state
   1. PS_TRANSFERS_RESERVED changes state to RECEIVED_PREPARE
   1. _ABORTED state for settlement is allowed to here_
   1. PS_TRANSFERS_COMMITTED shifts state to RECEIVED_FULFIL followed by COMMITTED
1. Finilise settlement to SETTLED
1. Repeat 1-6

Any part or the entire process described above may be automated via timed cron jobs or triggered by Central Event Processor rules.

## Resulting Functional Requirements

1. Acquire window(s) information:
   1. getSettlementWindowsByParams :: GET /settlementWindows?state=CLOSED&...
      * state - find windows by state
      * participantId - query windows by participantId
      * fromDateTime
      * toDateTime
      ```
      Possible improvements:
      * transferId - find window related to specified transfer UUID
      * participant - query windows by participant name
      * accountId - query windows by account
      * state=CLOSED|ABORTED - introduce OR operator maybe?
      ```
   1. getSettlementWindowById :: GET /settlementWindows/{id}

1. Close a window and open a new one automatically:
   * closeSettlementWindowById :: POST /settlementWindows/{id}
   ```
   Possible improvements:
   * HTTP method to be changed from POST to PUT as it is related to closing the provided window id
   * Response body may be omitted as next window may be presumed on success
   ```

1. Create a settlement and set all included windows to PENDING_SETTLEMENT
   * createSettlement :: POST /settlements

1. Acquire settlement(s) information
   1. getSettlementById :: GET /settlements/{id}
   1. getSettlementBySettlementParticipant :: GET /settlements/{id}/participants/{id}
   1. getSettlementBySettlementParticipantAccount :: GET /settlements/{id}/participants/{id}/accounts/{id}
   1. getSettlementsByParams :: GET /settlements?state=PENDING_SETTLEMENT&...
      * state - find settlements by state
      ```
      Possible improvements:
      * Query by state not available for PS_TRANSFERS_RECORDED, PS_TRANSFERS_RESERVED, PS_TRANSFERS_COMMITTED
      ```
      * fromDateTime
      * toDateTime
      * settlementWindowId - query by settlement window id
      * fromSettlementWindowDateTime
      * toSettlementWindowDateTime
      * participantId - query by participant id
      * accountId - query by accountId
      * currency - query by currency
      ```
      Possible improvements:
      * transferId - find settlement related to specified transfer UUID
      * participant - query by participant name
  1. Transition entire settlement and included settlement windows to SETTLED/ABORTED
     * updateSettlementById :: PUT /settlements/{id}
     * updateSettlementBySettlementParticipant :: PUT /settlements/{id}/participants/{id}
     * updateSettlementBySettlementParticipantAccount :: PUT /settlements/{id}/participants/{id}/accounts/{id}
     * abortSettlementById :: PUT /settlements/{id}
     ```
     Possible improvements:
     * abortSettlementById might be problematic. Consider usage of a different endpoint 
     for settlement abort operation to avoid programatic payload validation in favor
     of swagger validation
     * Switch to asynchronous settlements api workflow
     * Settlement transfer process to be processed by central-ledger microservice
     ```

## Non-Functional Requirements

1. Define settlement windows closure conditions (time, transfers count, positions threshold)
2. Define settlement conditions to SETTLE/ABORT
3. Decide on which segments of the settlement process should be chained

## OSS Settlement API Swagger Definition
[swagger.json](https://github.com/mojaloop/central-settlement/blob/master/src/interface/swagger.json)