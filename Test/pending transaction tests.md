# Pending transacton tests
Merchants are able to send a pending transaction. These show in their pending transaction list till resolved. Anyone can approve or reject a pending transaction sent to them. 

## Send pending transaction
Assumes the user is a merchant 
- (x) Send invoice for 0 
- (x) Send for valid amount to non-existent customer, get error
- Send pending transaction for a valid amount to valid customer

## Approve pending transaction
- Approve a transfer, the money and fees are transfered from approver's account. The principle goes to the pending transfer sender.
- (x) Approve a transfer when the amount exceeds the user's balance, get error and transaction is not sent or rejected.

## Reject pending transaction
- Reject the proposed transfer. Notification goes back to sender. 