# Account service API

-----

This service contains information about relations between users and their accounts. Accounts contain information for the following things:
 - Which account is primary for a given user
 - If particular user is signatory for a given account,
account service can manage user roles and their permissions. Each registered user has assigned role in the system and this role has predefined permissions about allowed actions.

Roles can be one of the following:
 * Customer
 * Merchant
 * Agent

Permissions are as follow:
 * p2p - User is able to send peer to peer transfers
 * cashIn - User is able to cash in
 * cashOut - User is able to cash out
 * invoice - User is able to issue an invoice / Sell goods
 * ministatement - User is able to check mini-statement menu
 * balanceCheck - User is able to check his balance

For the current moment permissions are set to the roles as follow:
 - Agent: p2p, ministatement, balanceCheck, cashIn, cashOut
 - Customer: p2p, ministatement, balanceCheck
 - Merchant: p2p, ministatement, balanceCheck, invoice

Account service exposes the following **private** API calls:

### Add actor to a given account ###

* **URL**

  `/rpc/account/actorAccount/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `accountId [number] - Account id`
   * `accountNumber [string] - Account number`
   * `actorId [string] - Actor id`
   * `roleName [string] - Name of the role`
   * `isDefault [boolean] - Is this the primary user's account`
   * `isSignatory [boolean] - Is this actor is signatory for this account`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account Id`
       * `actorId [string] - Actor Id`
       * `accountId [number] - Account Id`
       * `isDefault [boolean] - Is this the primary user's account`
       * `isSignatory [boolean] - Is this actor is signatory for this account`
       * `accountNumber [string] - Account number`
       * `permissions [string array] - Array with names of permissions`


### Edit actor data for account ###

* **URL**

  `/rpc/account/actorAccount/edit`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`
   * `accountId [number] - Account id`
   * `actorId [string] - Actor id`
   * `isDefault [boolean] - Is this the primary user's account`
   * `isSignatory [boolean] - Is this actor is signatory for this account`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account Id`
       * `actorId [string] - Actor Id`
       * `accountId [number] - Account Id`
       * `isDefault [boolean] - Is this the primary user's account`
       * `isSignatory [boolean] - Is this actor is signatory for this account`
       * `accountNumber [string] - Account number`
       * `permissions [string array] - Array with names of permissions`


### Fetch actor data for account ###

* **URL**

  `/rpc/account/actorAccount/fetch`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `accountId [number] - Account id`
   * `actorId [string] - Actor id`
   * `accountNumber [string] - Account number`
   * `isDefault [boolean] - Is this the primary user's account`
   * `isSignatory [boolean] - Is this actor is signatory for this account`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account Id`
       * `actorId [string] - Actor Id`
       * `accountId [number] - Account Id`
       * `isDefault [boolean] - Is this the primary user's account`
       * `isSignatory [boolean] - Is this actor is signatory for this account`
       * `accountNumber [string] - Account number`
       * `permissions [string array] - Array with names of permissions`


### Get actor data for account ###

* **URL**

  `/rpc/account/actorAccount/get`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account Id`
       * `actorId [string] - Actor Id`
       * `accountId [number] - Account Id`
       * `isDefault [boolean] - Is this the primary user's account`
       * `isSignatory [boolean] - Is this actor is signatory for this account`
       * `accountNumber [string] - Account number`
       * `permissions [string array] - Array with names of permissions`


### Remove actor data for account ###

* **URL**

  `/rpc/account/actorAccount/get`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `accountId [number] - Account id`


### Add permissions for account ###

* **URL**

  `/rpc/account/actorAccountPermission/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`
   * `permissions [string array] - Array with the name of the permissions`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account id`
       * `permissions [string array] - Array with the name of the permissions`


### Get permissions for account ###

* **URL**

  `/rpc/account/actorAccountPermission/get`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account id`
       * `permissions [string array] - Array with the name of the permissions`


### Remove permissions for account ###

* **URL**

  `/rpc/account/actorAccountPermission/remove`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorAccountId [number] - Actor account id`
   * `permissions [string array] - Array with the name of the permissions`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorAccountId [number] - Actor account Id`
       * `permissions [string array] - Array with names of permissions`


### Fetch account roles ###

* **URL**

  `/rpc/account/role/fetch`

* **Method**

  `POST`

* **Data Params**

  **Required**

   NONE

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `roleId [number] - Role Id`
       * `name [string] - Role name`
       * `description [string] - Role description`
