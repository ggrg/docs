# Testing Bulk Payments

## How to
The bulk payment is made through the DFSP admin UI which is port 8020 on the DFSP server.

The UI will ask for a user/password. Use any account on the DFSP as the user in the pattern
<phonenumber>@maker or <phonenumber>@checker to login as a maker or checker role. The password is the passwordof that account.

Accounts are created using the USSD interface, port 8019. Enter a random 10 digit phone number and walk through the menus to create an account. 

In the DFSP Admin UI the maker role uploads a CSV file with a group of payments to send. The checker role validates the payments and submits them. Bulk payments are considered lower priority and are throttled so that they don't go out all at once. 

The format of the bulk payment csv file is: 

`sequenceNumber,identifier,firstName,lastName,nationalId,dob,amount
`1,27713803905,bob,dylan,123456789,1999-12-10,1200
`2,27213971461,alice,cooper,987654321,1989-03-22,1500

* The sequence number is the order of the payments
* The identifier is the phone number
* DOB is date of birth in YYYY-MM-DD format
* Amount is the amount to send which can be any integer with up to 2 places after the decimal

