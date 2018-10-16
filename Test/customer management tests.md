# Customer Management Tests

## Association of a phone to a customer
A phone has an identifier that the DFSP uses to associate the phone with a customer. 

- If a customer connects using a phone with an unassociated identifier then the customer is asked to create an account.

- If the customer connects with a phone that has been associated with a customer, the customer recieves a menu of account actions. 

There is currently no way to associate another phone with the same customer.

## Add customer
A customer is identified by at least their name, birthdate, and an ID such as their national ID number. Adding a customer requires this data and returns the user number from the central directory service. Adding a customer creates at least one account for that customer in the DFSP.

- If customer already registered at that DFSP, then attemping to add the customer again from another phone (same name, birthdate, and ID) returns an error.

- If the fraud service returns 100, customer isn't added (error).

- A new customer can add themselves to the DFSP. The customer is registered in central directory associated to that DFSP.

- Different customers can be registered with same name and/or birthdate. 

- The same customer can be registered with multiple DFSPs, though they will have different customer numbers.
	
## Remove customer
- If the account owner closes the last account (see account management), the customer account closed at DFSP, and no customers can connect to that account. The customer is no longer associated with the DFSP in central directory and the phone will again ask for an account to be created. 

## Change password
Changing password functionality is not currently implemented [#420].
- Simple passwords are not allowed (all one number, straight runs, too short) [Not implemented: #331]
- A customer has a single password for all accounts in a DFSP. This is a convenience for our implementation, and not tested.

## Account Types
- There are several types of accounts that may be created: customer, agent, and merchant. A customer has only one account type and it is set when the customer is added. Currently there is no option to change account types or have different account types for for a single customer.

### Merchant accounts
- Merchant can send pending transactions, others can't send pending transactions but can approve them (manual verified).

### Agent accounts
- Agents start with two accounts: the main one and the commission account.

- Commission account can't be closed (no option exists, manually verified)

- The commission account can't be made the primary (error)
	
- Agents have the option to do Cash In and Cash Out transfers, others don't. The commission account can't send money, cash-in, cash-out, or pending transactions (manually verified).