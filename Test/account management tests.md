# Account Management Tests

Account management is internal to the DFSP service. It is tested and verified via the USSD interface.

## Use Cases

### Add account
A user can have zero or more accounts. The first account is made when the use signs up with the DFSP (see user management tests). Adding an account will add additional accounts for that user in the same DFSP.

The Account Name and Is Primary (Y/N) are required inputs. When a new account is created it shows up in the switch accounts list.

Currently, the account name is unique within DFSP. You can't create an identical account name for two different users. This is a convenience for the current implementation, and not tested. This restriction can be removed without loss of functionality.

### Close account
- Secondary accounts can be removed. 
- A non-signatory doesn't have the option to close an account. This is manually verified. 
- The primary account can't be closed (gives an error message when you try). 
- An account can't be closed if there is money in it. There's an error message when it's attempted.
- The account signatory can close an empty account.

### Switch account
- USSD shows the message: "You don't have any other account to switch to" when there is only one account.
- A user can switch between available accounts when there is more than one.
	
### Primary (default) Account
- When there is more than one account, the primary account is where money will be sent. 
- A new account can be made primary when it is created. The previous primary account will become a secondary account.
- A secondary account can be made primary. The previous primary account will become a secondary account.

### Additional holders (users)
The original holder for the account is considered the owner. For now, there is no option to change owners. Additonal holders can be signatory or non-signatory. 
 
#### Add additional holder to account
- Non-signatory can't add a user. There's no option for this and it is manually verified.

- A signatory for the account can add other users to an account as a holder of that account. If a user is added to someone else's account, that user can see the new account in their list of accounts to switch to. They can switch to the account and do things like see the balance.
	
#### Remove additional holder from account
- The original owner (first user) of the account can't be removed. (requires remove user from DFSP). This gives an error when attempted.

- A non-signatory can't remove anyone. There is no option to do this and it is manually verified.

- A signatory can remove another user from an account who is not the owner. 
	
### Account Permissions
- The owner is a signatory and they have same menus (manually verified). An owner can't be made non-signatory (error).

- A signatory can change another holder, who is not an owner, from signatory to non-signatory and vice-versa. 

- A non-signatory holder can't send money or manage accounts. They can send invoices, look at the mini-statement, and account balance (manually verified).