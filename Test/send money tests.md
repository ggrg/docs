# Send Money Tests

As part of the [Level One principles](https://leveloneproject.org/wp-content/uploads/2016/03/L1P_Level-One-Principles-and-Perspective.pdf), the customer must be able to see at least the name of the person or business they are sending their money to and the full cost of the transfer, broken out by principle and total fees, before they approve sending money. Money can only be sent (pushed) not debited (pulled).

## Variations
Instead of listing every case, we list the equivalence classes for variations that can be done when sending money. These include positive cases, positive and negative boundary cases, and invalid cases. In all positive cases, the fulfillment should be recorded in the ledgers of both the payee and payer DFSPs and the central ledger. Under no cases should the payment not be represented correctly in all three ledgers, though for some negative cases, the matching will require services to be restarted or connections to be reestablished.

Combinations of some equivalence classes should be tried. In general, negative cases, marked (x), are not combined with other variations unless mentioned and should have an error message.

### Destinations
- Payer and Payee are on the same DFSP
- Payer and Payee are on separate DFSPs
- (x) Invalid Destination customer

### Customers
Combine with destinations
- Same customer
- Different customer
- Same customer, different account but same DFSP


### Test Matrix
This test matrix condenses the positive cases above into two simple tests. Other variations are covered below and in other tests. 

|Destination|Customer|
|-----------|--------|
| Same DFSP | Same customer different account|
| Different DFSP | Same customer but different ID  |

### Amount to send
Amounts don't need to be combined with other variations. 
- 1
- Some
- Exact account balance
- (x) More than account balance due to fees
- (x) More than account balance

### DFSP Limits
Limits to the number of transfers in a day, the maximum account size, or the maximum transfer amount are configuration limits implemented at the DFSP and don't need to be combined with tests of other services.

If there is a limit on the number of transfers, then a cancelled or rejected transfer still counts against a customer limit. Refunds are separate transfers initiated by the DFSP that do not count against a customer limit. 
Sending to yourself on the same DFSP shouldn't be counted toward any limits.

Configuration: Verify limits can be set to both none and some amount. Changing the limits should be logged to the forensic log.

Set the maximum number of transfers and transaction size low (2) and try:
- The maxmimum number of transfers in a day 
- (x) One more than the maximum number of transfers per day
- Send the maximum tansaction size
- (x) Send more than the maximum transaction size
- exceeding limits to yourself (should work)

### States
A transfer can be one of several states. Some of the states have multiple ways they can occur. Each of these variations needs to be tested, but don't need to be combined with other variations.

To be able to test the cancel states we need to be able to hold the sending of a the payment messages in each service till after the timeout. Likewise, to test the rejection states we need to be able to force a rejection from the center or the DFSPs.

Here are the list of possible states::
- Unknown
    - Preparing and within timeout. This is part of the normal flow, it tested in regular end to end tests.
	- After timeout, but not notified. This happens when a service is down or a message is dropped and is tested in the resilience tests below.
- Cancelled (timeout)
	- Payer DFSP timeout. After the quote the payer DFSP doesn't send the prepare till it has already timed out. If it attempts to send it anyway, the center should reject the prepare and the sender should show a cancellation to the customer.
	- Center timeout during prepare. The center sits on the payment till it times out. 
	- Payee DFSP timeout. The receiver sends a cancel notification.
	- Center timeout during fulfill. The center acknowledges the fulfill message, but sends a cancellation for the notification to both sender and receiver.
	- Final Payee timeout. In this state the transfer is already fulfilled. Even if the timeout occurs after reciept by the sender but before the sender ledger handles it, the sender DFSP should process the transfer.
- Rejected
    - Payer DFSP rejects (ex: fraud or insufficient account funds)
	- Center rejects (ex: insufficient settlement funds)
	- Payee rejects (ex: fraud)
- Fulfilled

See settlement tests below for additional validations.

### Thread contention/Sequence errors
- Remove a destination user after the quote but before the transfer is recieved be the destination DFSP. This should result in a rejection of the transfer by the Payee DFSP.

### Time skew
- Verify time skew is not relevant by setting each service on different dates and sending money. It is expected that the cross-service logs will show odd times. 

### Resilience
Despite the failures listed below, no ledger should lose money and the transfer should eventually succeed when the failure is resolved. These are negative tests and not combined with other variations.

- Message failures. The failures occur when messages are dropped or not sent
    - Halt fulfillment notification messages for center
    - Halt fulfillment notification messages for payee DFSP
    - Halt fulfillment notification messages for payer DFSP. 
Transfer should go through due to retries when the connection is re-established.

- Service failures. In each case the payment should complete afer the service is restarted. 
    - Take down payee DFSP after quote
    - Take down center DFSP before and after prepare
    - Take down payer ledger adapter after prepare
    - Take down client when a transfer is unknown (is retry initiated by the DFSP when the client is restarted?)

- Verify Idempotence - cause retries and verify only 1 transaction on ledgers for both DFSPs and the center.

### Settlement
To support deferred net settlement, the central ledger can easily list:

- Fulfilled transfers 
    - with fees broken out for separate accounts.
- Balances by DFSP
- Cancelled and rejected transfers
- Unknown expired transfers

 The firt two are tested as part of fees testing. The latter two should be tested during state testing. 

## Refunds
Refunds are not currently implemented.

In this system all transfers are final, so a a refund is a second transfer in the opposite direction for the original amount including both principle and fees. It contains data to link it to the original transfer it is negating for auditing purposes.

DFSPs typically do not charge fees for the refund. 

The refund is marked as such so that the central ledger can report on it appropriately.

Refunds may be charged a central fee if that is charged to every other transfer, which the DFSP can choose to pass on to the customer or not. 

