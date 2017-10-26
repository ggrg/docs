# Transfer service API

-----

This service contains information about transfers, invoices and invoice notifications. It is used to hold the following data:
 - Invoices when they are created by merchants
 - Invoice notifications when they are sent from merchant's DFSP to the client's DFSP
 - Invoice types
 - Invoice statuses
 - Invoice payments

Invoice types can be one of the following:
 * Standard - Standard invoices
 * Pending - Not assigned one-time invoice
 * Product - Not assigned multy-payer invoice
 * CashOut - Cash out invoices

Invoice statuses are:
 * executed - Invoice has been executed by customer
 * approved - Invoice has been approved by customer
 * pending - Invoice is pending
 * rejected - Invoice has been rejected by customer
 * cancelled - Invoice has been cancelled by merchant

Transfer service exposes the following **private** API calls in two spaces - `[bulk]` and `[transfer]`:

### Add batch ###

* **URL**

  `/rpc/bulk/batch/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `name [string] - Batch name`
   * `actorId [string] - Actor id`
   * `fileName [string] - File name`
   * `originalFileName [string] - Original file name`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch id`
       * `name [string] - Batch name`
       * `batchStatusId [number] - Batch status id`
       * `actorId [string] - Actor id`

### Edit batch ###

* **URL**

  `/rpc/bulk/batch/edit`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorId [string] - Actor id`
   * `batchId [number] - Batch Id`

   **Optional**

   * `account [string] - Account`
   * `startDate [date] - Batch start date`
   * `expirationDate [date] - Batch expiration date`
   * `name [string] - Batch name`
   * `batchStatusId [number] - Batch status id`
   * `batchInfo [string] - Batch info`
   * `uploadInfo [string] - Upload info`
   * `fileName [string] - Batch file name`
   * `originalFileName [string] - Batch original file name`
   * `validatedAt [date] - Batch validation date`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch Id`
       * `account [string] - Account`
       * `startDate [date] - Batch start date`
       * `expirationDate [date] - Batch expiration date`
       * `name [string] - Batch name`
       * `batchStatusId [number] - Batch status id`
       * `batchInfo [string] - Batch info`
       * `uploadInfo [string] - Upload info`
       * `actorId [string] - Actor id`
       * `fileName [string] - Batch file name`
       * `originalFileName [string] - Batch original file name`
       * `validatedAt [date] - Batch validation date`


### Fetch batch ###

* **URL**

  `/rpc/bulk/batch/fetch`

* **Method**

  `POST`

* **Data Params**

   **Optional**

   * `actorId [string] - Actor id`
   * `name [string] - Batch name`
   * `batchStatusId [number] - Batch status id`
   * `fromDate [date] - From date`
   * `toDate [date] - To date`

** Note: **`'fromDate'` and `'toDate'` are related to the creation date of the batch. They are not related to the `'startDate'` and `'expirationDate'` of the batch.

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch Id`
       * `account [string] - Account`
       * `startDate [date] - Batch start date`
       * `expirationDate [date] - Batch expiration date`
       * `name [string] - Batch name`
       * `batchStatusId [number] - Batch status id`
       * `batchInfo [string] - Batch info`
       * `uploadInfo [string] - Upload info`
       * `actorId [string] - Actor id`
       * `fileName [string] - Batch file name`
       * `originalFileName [string] - Batch original file name`
       * `validatedAt [date] - Batch validation date`


### Get batch ###

* **URL**

  `/rpc/bulk/batch/get`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `batchId [number] - Batch id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch Id`
       * `name [string] - Batch name`
       * `account [string] - Account`
       * `startDate [date] - Batch start date`
       * `expirationDate [date] - Batch expiration date`
       * `batchStatusId [number] - Batch status id`
       * `actorId [string] - Actor id`
       * `info [string] - Batch info`
       * `fileName [string] - Batch file name`
       * `originalFileName [string] - Batch original file name`
       * `createdAt [date] - Batch create date`
       * `status [string] - Batch status`
       * `updateAd [date] - Batch update date`
       * `paymentsCount [number] - Batch payments count`


### Process batch ###

* **URL**

  `/rpc/bulk/batch/process`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `batchId [number] - Batch id`
   * `actorId [string] - Actor id`
   * `startDate [date] - Batch start date`
   * `expirationDate [date] - Batch expiration date`
   * `account [string] - Account`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `queued [number] - Count of the payments added in the queue`


### Batch ready ###

* **URL**

  `/rpc/bulk/batch/ready`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `batchId [number] - Batch id`
   * `actorId [string] - Actor id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch Id`
       * `account [string] - Account`
       * `startDate [date] - Batch start date`
       * `expirationDate [date] - Batch expiration date`
       * `name [string] - Batch name`
       * `batchStatusId [number] - Batch status id`
       * `batchInfo [string] - Batch info`
       * `uploadInfo [string] - Upload info`
       * `actorId [string] - Actor id`
       * `fileName [string] - Batch file name`
       * `originalFileName [string] - Batch original file name`
       * `validatedAt [date] - Batch validation date`


### Batch revert status ###

* **URL**

  `/rpc/bulk/batch/revertStatus`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `batchId [number] - Batch id`
   * `actorId [string] - Actor id`
   * `partial [boolean] - Is it one payment checked or whole batch`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `batchId [number] - Batch Id`
       * `account [string] - Account`
       * `startDate [date] - Batch start date`
       * `expirationDate [date] - Batch expiration date`
       * `name [string] - Batch name`
       * `batchStatusId [number] - Batch status id`
       * `batchInfo [string] - Batch info`
       * `uploadInfo [string] - Upload info`
       * `actorId [string] - Actor id`
       * `fileName [string] - Batch file name`
       * `originalFileName [string] - Batch original file name`
       * `validatedAt [date] - Batch validation date`


### Fetch batch status ###

* **URL**

  `/rpc/bulk/batchStatus/fetch`

* **Method**

  `POST`

* **Data Params**

   **Required**
    NONE

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `key [number] - Status key`
       * `name [string] - Status name`
       * `description [string] - Status description`


### Add payments ###

* **URL**

  `/rpc/bulk/payment/add`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `actorId [string] - Actor id`
   * `payments [json] - json containing list with payments`
   * `batchId [number] - Batch id`

`payments` should have the following fields included:
 - `sequenceNumber [number] - Sequence number`
 - `identifier [string] - User's identifier`
 - `firstName [string] - User's first name`
 - `lastName [string] - User's last name`
 - `dob [date] - Date of birth`
 - `nationalId [string] - National Id`
 - `amount [number] - Amount`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `insertedRows [number] - Count of inserted payments`


### Edit payments ###

* **URL**

  `/rpc/bulk/payment/add`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `actorId [string] - Actor id`
   * `payments [json] - json containing list with payments`


`payments` should have the following fields included:
 - `paymentId [number] - Payment id`
 - `batchId [number] - Batch id`
 - `sequenceNumber [number] - Sequence number`
 - `identifier [string] - User's identifier`
 - `firstName [string] - User's first name`
 - `lastName [string] - User's last name`
 - `dob [date] - Date of birth`
 - `nationalId [string] - National Id`
 - `amount [number] - Amount`
 - `info [string] - Payment info`
 - `payee [json] - Payee info`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `payments [json] - json with the edited payments`


### Fetch payments ###

* **URL**

  `/rpc/bulk/payment/fetch`

* **Method**

  `POST`

* **Data Params**

   **Optional**

   * `paymentId [number array] - Array with payment ids`
   * `batchId [number] - Batch id`
   * `nationalId [string] - Batch id`
   * `paymentStatusId [number array] - Array with payment status ids`
   * `fromDate [date] - From date`
   * `toDate [date] - To date`
   * `sequenceNumber [number] - Sequence number`
   * `name [string] - Batch name`
   * `pageSize [number] - Page size`
   * `pageNumber [number] - Page number`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `data [json] - Result set from the search`
       * `pagination [json] - json with the following fields included`
          - `'pageNumber'` - Requested page number
          - `'pageSize'` - Returned payments from the result set for this page
          - `'pagesTotal'` - Returned count of pages from the result set
          - `'recordsTotal'` - Total count of payments matched from search


### Get payment ###

* **URL**

  `/rpc/bulk/payment/get`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `paymentId [number] - Array with payment ids`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `paymentId [number] - Payment id`
       * `batchId [number] - Batch id`
       * `sequenceNumber [number] - Sequence number`
       * `identifier [string] - User's identifier`
       * `firstName [string] - User's first name`
       * `lastName [string] - User's last name`
       * `dob [date] - User's date of birth`
       * `nationalId [string] - User's national id`
       * `amount [number] - Transfer amount`
       * `paymentStatusId [number] - Payment status id`
       * `info [string] - Payment info`
       * `payee [json] - Payee data`
       * `name [string] - Batch name`
       * `createdAt [date] - Payment's created at date`
       * `updatedAt [date] - Payment's updated at date`
       * `account [string] - Batch account`
       * `startDate [date] - Batch's start date`
       * `expirationDate [date] - Batch's expiration date`
       * `actorId [string] - Actor id`


### Get payments for processing ###

* **URL**

  `/rpc/bulk/payment/getForProcessing`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `count [number] - Number of payments to be returned. Default is set to 100`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `paymentId [number] - Payment id`
       * `batchId [number] - Batch id`
       * `sequenceNumber [number] - Sequence number`
       * `identifier [string] - User's identifier`
       * `firstName [string] - User's first name`
       * `lastName [string] - User's last name`
       * `dob [date] - User's date of birth`
       * `nationalId [string] - User's national id`
       * `amount [number] - Transfer amount`
       * `paymentStatusId [number] - Payment status id`
       * `info [string] - Payment info`
       * `createdAt [date] - Payment's created at date`
       * `updatedAt [date] - Payment's updated at date`


### Pre-process payment ###

* **URL**

  `/rpc/bulk/payment/preProcess`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `paymentId [number] - Payment id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `paymentId [number] - Payment id`
       * `batchId [number] - Batch id`
       * `sequenceNumber [number] - Sequence number`
       * `identifier [string] - User's identifier`
       * `firstName [string] - User's first name`
       * `lastName [string] - User's last name`
       * `dob [date] - User's date of birth`
       * `nationalId [string] - User's national id`
       * `amount [number] - Transfer amount`
       * `paymentStatusId [number] - Payment status id`
       * `info [string] - Payment info`
       * `payee [json] - Payee data`
       * `name [string] - Batch name`
       * `createdAt [date] - Payment's created at date`
       * `updatedAt [date] - Payment's updated at date`
       * `account [string] - Batch account`
       * `startDate [date] - Batch's start date`
       * `expirationDate [date] - Batch's expiration date`
       * `actorId [string] - Actor id`


### Process payment ###

* **URL**

  `/rpc/bulk/payment/process`

* **Method**

  `POST`

* **Data Params**

   **Required**

   * `paymentId [number] - Payment id`
   * `actorId [string] - Actor id`
   * `error [string] - Error message`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `paymentId [number] - Payment id`
       * `batchId [number] - Batch id`
       * `sequenceNumber [number] - Sequence number`
       * `identifier [string] - User's identifier`
       * `firstName [string] - User's first name`
       * `lastName [string] - User's last name`
       * `dob [date] - User's date of birth`
       * `nationalId [string] - User's national id`
       * `amount [number] - Transfer amount`
       * `paymentStatusId [number] - Payment status id`
       * `info [string] - Payment info`
       * `payee [json] - Payee data`
       * `name [string] - Batch name`
       * `createdAt [date] - Payment's created at date`
       * `updatedAt [date] - Payment's updated at date`
       * `account [string] - Batch account`
       * `startDate [date] - Batch's start date`
       * `expirationDate [date] - Batch's expiration date`
       * `actorId [string] - Actor id`


### Fetch payment statuses ###

* **URL**

  `/rpc/bulk/paymentStatus/fetch`

* **Method**

  `POST`

* **Data Params**

   **Required**

    NONE

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `key [number] - Payment status key`
       * `name [string] - Payment status name`
       * `description [string] - Payment status description`


### Add invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/add`

* **Method**

  `POST`

* **Data Params**


  **Required**

   * `invoiceUrl [string] - Invoice URL`
   * `identifier [string] - Identifier`
   * `memo [string] - Invoice memo`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`


### Cancel invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/cancel`

* **Method**

  `POST`

* **Data Params**


  **Required**

   * `invoiceUrl [string] - Invoice URL`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`


### Edit invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/edit`

* **Method**

  `POST`

* **Data Params**


  **Required**

   * `invoiceNotificationId [number] - Invoice notification id`
   * `invoiceNotificationStatusId [number] - Invoice notification status id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`


### Execute invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/execute`

* **Method**

  `POST`

* **Data Params**


  **Required**

   * `invoiceNotificationId [number] - Invoice notification id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`

### Fetch invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/fetch`

* **Method**

  `POST`

* **Data Params**


  **Required**

   * `identifier [string] - Identifier`
   * `status [string] - Invoice notification id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`


### Get invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/get`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `invoiceNotificationId [number] - Invoice notification id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`

### Reject invoice notification ###

* **URL**

  `/rpc/transfer/invoiceNotification/reject`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `invoiceNotificationId [number] - Invoice notification id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoiceNotificationId [number] - Invoice notification id`
       * `invoiceUrl [string] - Invoice URL`
       * `identifier [string] - Identifier`
       * `status [string] - Invoice status`
       * `memo [string] - Invoice memo`       


### Invoice add ###

* **URL**

  `/rpc/transfer/invoice/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `account [string] - Account`
   * `name [string] - Name`
   * `currencyCode [string] - Currency code`
   * `amount [number] - Amount`
   * `merchantIdentifier [string] - Merchant identifier`
   * `identifier [string] - Client identifier`
   * `invoiceType [string] - Invoice type`
   * `invoiceInfo [string] - Invoice info`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice cancel ###

* **URL**

  `/rpc/transfer/invoice/cancel`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `invoiceId [number] - Invoice id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice edit ###

* **URL**

  `/rpc/transfer/invoice/edit`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `invoiceId [number] - Invoice id`
   * `invoiceStatusId [number] - Invoice status id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice execute ###

* **URL**

  `/rpc/transfer/invoice/edit`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `invoiceId [number] - Invoice id`
   * `identifier [string] - Identifier`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice fetch ###

* **URL**

  `/rpc/transfer/invoice/fetch`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `merchantIdentifier [string] - Merchant identifier`
   * `account [string] - Account`
   * `status [string array] - Array with invoice statuses`
   * `invoiceType [string array] - Array with invoice types`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice get ###

* **URL**

  `/rpc/transfer/invoice/get`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `invoiceId [number] - Invoice id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice reject ###

* **URL**

  `/rpc/transfer/invoice/reject`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `invoiceId [number] - Invoice id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `type [string] - Invoice type`
       * `invoiceId [number] - Invoice id`
       * `account [string] - Account`
       * `name [string] - Name`
       * `currencyCode [string] - Currency code`   
       * `currencySymbol [string] - Currency symbol`   
       * `amount [number] - Amount`  
       * `status [string] - Invoice status`  
       * `invoiceType [string] - Invoice type`
       * `merchantIdentifier [string] - Merchant identifier`
       * `invoiceInfo [string] - Invoice info`


### Invoice payer add ###

* **URL**

  `/rpc/transfer/invoicePayer/add`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `invoiceId [number] - Invoice id`
   * `identifier [string] - Identifier`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoicePayerId [number] - Invoice payer id`
       * `invoiceId [number] - Invoice id`
       * `identifier [string] - Identifier`
       * `createdAt [date] - Created at date`


### Invoice payer fetch ###

* **URL**

  `/rpc/transfer/invoicePayer/fetch`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `invoiceId [number] - Invoice id`
   * `paid [boolean] - Paid`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoicePayerId [number] - Invoice payer id`
       * `invoiceId [number] - Invoice id`
       * `identifier [string] - Identifier`
       * `createdAt [date] - Created at date`


### Invoice payer get ###

* **URL**

  `/rpc/transfer/invoicePayer/get`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `invoicePayerId [number] - Invoice payer id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `invoicePayerId [number] - Invoice payer id`
       * `invoiceId [number] - Invoice id`
       * `identifier [string] - Identifier`
       * `createdAt [date] - Created at date`


### Transfer push execute ###

* **URL**

  `/rpc/transfer/push/execute`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `sourceAccount [string] - Source account`
   * `receiver [string] - Receiver`
   * `destinationAmount [number] - Destination amount`
   * `currency [string] - Currency code`
   * `fee [number] - Fee amount`
   * `memo [string] - Transaction memo`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `id [string] - Payment id`
       * `address [string] - Address`
       * `destinationAmount [number] - Destination amount`
       * `sourceAmount [number] - Source amount`
       * `sourceAccount [string] - Source account`
       * `expiresAt [date] - Expiration date`
       * `condition [string] - Condition`
       * `fulfillment [string] - Fulfillment`
       * `status [string] - Status`
