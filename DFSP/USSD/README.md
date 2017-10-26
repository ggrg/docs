# USSD

The purpose of USSD simulator is to simulate a real USSD interface over HTTP. It can send the requests to USSD server and display the responses from it. It is designed as a featured phone on which the user can click buttons and see numbers or text on the screen. Additionally there is a log console where the user can see the requests and responses that have been exchanged with the server. It also has an text box where the user has to enter the phone or user number that the simulator will work with. In an actual scenario, this information is coming from the GSM network and passed to the USSD server. The USSD simulator has a timer that can be started and stop and can be used to measure how long a use case or set of actions will take.

## Simulator Functions

An image of the emulator appears below, with the controls identified with a letter in a rectangle. The correspodning control explanations follow the image.


![](./HomeScreen.png)


**A. Screen where the responses from the USSD server are displayed.** The response usually is limited to maximum 160 character (including spaces and new lines). Ifthe USSD text is in Unicode or any other 16 bit encoding, the responses from the server are limited to 80 characters

**B. Input box for the requests send to the USSD server.** Usually a USSD session is started by dialing a short code in with a pattern *DDDD#, where D can be any digit from 0 to 9.

**C. Phone or user number of the user currently working with the emulator.** In the real life case this number is coming from the GSM network. In this  box the user can enter also text.

**D. Timer**. The user can start and stop it by clicking on it.

**E. USSD log**. In this box a log for the requests and responses is displayed.

**F. Confirm button.** This button sends the data from box 'B' to the server.

**G. Cancel button.** This button terminates the current USSD session.

**H. Hash button.** Button for switching between numbers and text. To enable the text function you need to click on the button and hold it for 2 seconds.



## Access

The simulator is accessible without credentials on [/ussd](http://ec2-52-37-54-209.us-west-2.compute.amazonaws.com:8019/ussd/ "/ussd") path where dfsp-ussd service is hosted.



## Use Cases

### 1. Customer on-boarding (only for testing purpose)

The use case is developed for testing purposes. It registers a user with an account and credentials DFSP Identity, DFSP Subscription, DFSP Account and DFSP ledger services. It also sends the user into DFSP directory gateway.

#### 1.1
To register as a new customer, the user must enter their phone number via the USSD menu. The DFSP then checks whether the provided phone is already associated with an existing user, and in case no such user is found, the USSD displays the following screen, where the user must select the Open account command:

![](./RegisterNewCustomer.PNG)

#### 1.2
On the following screen the user must enter their user number or allow the system to create one for them automatically.

![](./NewUserNumber.PNG)

#### 1.3
On the following screen the user must enter their first name.

![](./NewUserFirstName.PNG)

#### 1.4
On the following screen the user must enter their last name.

![](./NewUserLastName.PNG)

#### 1.5
On the following screen the user must enter their date of birth.

![](./NewUserDoB.PNG)

#### 1.6
On the following screen the user must enter their national ID.

![](./NewUserNatID.PNG)

#### 1.7
On the following screen the user must provide a PIN.

![](./NewUserPIN.PNG)

#### 1.8
On the following screen the user must provide an account name.

![](./NewUserAccountName.PNG)

#### 1.9
A confirmation screen appears, containing information about the user number.

![](./NewUserSuccess.PNG)

Next time the use logs in using their phone number, the system recognizes them and displays the standard welcome screen.

![](./NewUserNewLogin.PNG)

----------

### 2.
Send money from Person-to-Person

In the Send money user case, a transfer is wired to another user, who can be in different DFSP. When the user number of the receiver is entered, the system display its name. When the amount is entered the system displays the fees that the user which sends the money has to pay. A final confirmation screen is displayed where the user has to enter his PIN.

#### 2.1
The user case starts by entering an existing user number into the phone box of the simulator and selecting 'Send Money' menu item.

![](./SendMoney1.JPG)

#### 2.2
On the following screen the user has to enter the destination account number.

![](./SendMoney2.JPG)

#### 2.3
The system displays the name of the user who is going to receive the money and the currency its account. Then the user has to enter the amount that to send.

![](./SendMoney3.JPG)

#### 2.4
The system display both local and connector fees and expects the confirmation of the transaction with the user PIN.

![](./SendMoney4.JPG)


#### 2.5
The system displays a final screen with the transaction status, the recipient name, the amount and the currency. The user can return to the home screen execute another transaction.

![](./SendMoney5.JPG)

----------

### 3.
Sell Goods

In the Sell Goods use case, a merchant sends an invoice to a buyer who can be in different DFSP. When the user number of the receiver is entered, the system display its name. When the amount is entered the system displays the fees that the user which sends the money has to pay. A final confirmation screen is displayed in which the user has to enter his PIN.

#### 3.1
The user case starts by entering an existing user number into the phone box of the simulator and selecting 'Sell Goods' menu item.

![](./SellGoods_1.PNG)

#### 3.2
On the following screen the merchant has to enter the amount of the invoice.

![](./SellGoods_2.PNG)

#### 3.3
The system displays the buyer name and the amount, and expects the confirmation of the invoice with the user PIN.

![](./SellGoods_3.PNG)

---------

### 4.
Pending Transactions

In th Pending Transactions use case, a buyer approves or rejects a pending invoice from a merchant who can be in different DFSP. When the user number of the receiver is entered, the system display its name. A final confirmation screen is displayed where the user has to enter his PIN.

#### 4.1
The user case starts by selecting the 'Sell Goods' menu item, and then selecting the pending invoice displayed on the screen.

![](./PendingTransaction_1.PNG)

#### 4.2
On the following screen the system displays the name of the merchant and the amount of the invoice to be paid. The user has to confirm by entering his PIN, or he can reject by selecting the 'Reject' menu item.

![](./PendingTransaction_2.PNG)

#### 4.3
A confirmation screen is displayed

![](./PendingTransaction_3.PNG)

### 5.
Manage Accounts

The Manage Account USSD menu command enables users to manage their accounts, namely to add, edit, and close an account. They can also get account information, and add or remove account holders.

![](./Manage_Accounts.png)

#### 5.1
Adding an account

To add an account, the user selects the Add account USSD menu, then enters a name for the new account.

![](./Add_Account.PNG)

Then the user is prompted to define whether the new account will be a primary one or not.

![](./Primary_Account.PNG)

The user confirms their choice by entering their PIN, and a confirmation message displays. Next time the user uses the USSD menu, they are prompted to select one of their accounts before proceeding any further.

![](./Select_Account.PNG)

#### 5.2
Editing an account

The user can edit an existing account by changing its name, or by setting it as primary.
The user selects one of their existing accounts, then selects the Manage account USSD menu command, after that they select the Edit account USSD menu command.

![](./Edit_Account.PNG)

To edit the name of an account, the user must enter a new name after the prompt.

![](./Edit_AccountName.PNG)

To make the current account the primary one, the user must enter their PIN to confirm their choice. A confirmation message displays.

![](./Edit_PrimaryAccount.PNG)

#### 5.3
Closing an account

The user can close any account that is not currently set to primary and which does not have any funds.
To close an account, the user must select the Manage account USSD menu command, then select the Close account command. The user enters their PIN to confirm, and a message displays.

![](./Close_Account.PNG)

The user is switched to their primary account.

#### 5.4
Viewing account information

The user can view information about their current account. They must select the Manage account USSD menu command, then select the Account info command.

![](./Account_Info.PNG)

#### 5.5
Add holder

The user can add another user as an account holder. They must select the Manage account USSD menu command, then select the Add holder command. The user is prompted to enter the identifier of the new account holder, then they must select whether the new account holder will be signatory or not. Signatory holders are persons who can move money from the account.

![](./Add_Signatory_Account_Holder.PNG)

The user enters their PIN to confirm, and a message is displayed.

![](./Confirm_Add_Account_Holder.PNG)

#### 5.6
Remove holder

The user can remove an account holder they have previously added to their account. Please note that the user cannot remove themselves as account holders.
To remove an account holder, the user must select the Manage account USSD menu command, then select the Remove holder command. The user is prompted to select the account holder they want to remove.

![](./Remove_Account_Holder.PNG)

The user enters their PIN to confirm, and a message is displayed.

![](./Confirm_Remove_Account_Holder.PNG)


### 6.
Switching accounts

The user can easily switch between their accounts by selecting the Switch account USSD menu command.
Information about the current account and all available accounts for the user is displayed. The user is prompted to select another existing account to switch to.

![](./Switch_Account.PNG)


### 7.
Checking Balance

The Check Balance USSD menu command enables users to check their current balance.
The user selects the 'Check balance' menu item, and their current balance displays on the screen.

![](./Screen_Balance.PNG)

### 8.
Checking Ministatement

The user can check their ministatement by selecting the Ministatement USSD menu command.
They are prompted to enter their PIN, then the ministatement information displays.

![](./Ministatement.PNG)
