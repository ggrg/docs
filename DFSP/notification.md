# Notification Service API

Notification service is responsible for SMS, email and smart app notifications. The service chooses the appropriate channels and devices for the notification.

## Notification.message.add
Adds message to notification queue
	* parameters
    	* sourceUser - the unique identifier of the source user
    	* destinationUser - the unique identifier of the destination user
    	* sourceAccount
    	* destinationAccount
    	* sourceAmount
    	* destinationAmount
    	* sourceCurrency
    	* destinationCurrency
    	* message - the sender's message
    	* dateTime - the date and time of the transfer
    	* transactionType - the type of the transaction (p2p, cash in, cash out, pending, vouchers, and so on)
	* result
    	* notificationId - a unique identifier of the notification
	* errors
    	* notification.invalid~ - invalid parameter
