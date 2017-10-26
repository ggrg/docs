# Identity Service API

-----

Identity Service is used for managing identity related data, such as sessions, images, PINs, and so on. This service contains information about all the available actions and
the roles that can perform them.

Roles can be one of the following:

 * common - Default roles
 * maker - Batch payment maker role
 * checker - Batch payment checker role

Actions are defined as follow:

 * bulk.batch.add - Create new batch
 * bulk.batch.edit - Edit batch
 * bulk.batch.fetch - Fetch batches by criteria
 * bulk.batch.get - Get batch details
 * bulk.batch.reject - Reject batch
 * bulk.batch.disable - Disable batch
 * bulk.batch.pay - Pay batch
 * bulk.batch.check - Check batch
 * bulk.batch.ready - Mark batch as ready
 * bulk.batch.delete - Mark batch as deleted
 * bulk.batch.process - Process batch
 * bulk.payment.check - Check payment details
 * bulk.payment.disable - Disable payment
 * bulk.payment.edit - Edit payment
 * bulk.payment.fetch - Fetch payments
 * bulk.payment.add - Create payment
 * bulk.paymentStatus.fetch - Fetch list with payment statuses
 * bulk.batchStatus.fetch - Fetch list with batch statuse
 * core.transaltion.fetch - Translation fetch
 * rule.rule.fetch - Rule fetch
 * rule.item.fetch - Item fetch
 * rule.rule.add - Rule add
 * rule.rule.edit - Rule edit
 * ledger.account.fetch - Fetch accounts

Identity service has exposed the **private** API calls in the following sections:

### Login action ###

* **URL**

  `/login`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorId [string] - Actor id`
   * `username [string] - Username`
   * `password [string] - Login password`
   * `sessionId [string] - Generated session id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `identity.check [json] - json containing following fields`
         - `actorId [string] - Actor id`
         - `sessionId [string] - Session id`
       * `permission.get [json] - json containing following fields`
         - `actionId [string]- action id`
         - `objectId [string] - object id`
         - `description [string] - action description`
       * `language [json] - json with user language`
       * `localisation [json] - json with the following fields`
         - `dateFormat [string] - Date format`
         - `numberFormat [string] - Number format`
       * `roles [json] - json containing user roles`
       * `screenHeader [string] - Screen header`


### Identity add ###

* **URL**

  `/rpc/identity/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorId [string] - Actor id`
   * `type [string] - Type`
   * `identifier [string] - User identifier`
   * `algorithm [string] - Used algorithm`
   * `params [string] - Input params`
   * `value [string] - Input value`
   * `roles [string array] - Array of role names`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actor [json] - json containing following fields`
         - `actorId [string] - Actor id`


### Identity close session ###

* **URL**

  `/rpc/identity/closeSession`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorId [string] - Actor id`
   * `sessionId [string] - Generated session id`


* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `data [json] - json containing empty array`


### Identity get ###

* **URL**

  `/rpc/identity/get`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `username [string] - Username`
   * `actorId [string] - Actor id`
   * `type [string] - Type: password/ussd`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `hashParams [json] - json containing following fields`
            - `params [string] - params`
            - `algorithm [string] - algorithm`
            - `actorId [string] - Actor id`
            - `type [string] - Type: password/ussd`
       * `roles [json] - json containing all assigned roles for this actorId`
