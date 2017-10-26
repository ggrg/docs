# Subscription service API

-----

This service is used for mapping between users and phone numbers. It supports the following **private** API calls:

### Add subscription ###

* **URL**

  `/rpc/subscription/subscription/add`

* **Method**

  `POST`

* **Data Params**

  **Required**

   * `actorId [string] - Actor id`
   * `phoneNumber [string] - Phone number`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `subscriptionId [number] - Subscription id`
       * `actorId [string] - Actor id`
       * `phoneNumber [string] - Phone number`


### Get subscription ###

* **URL**

  `/rpc/subscription/subscription/get`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `actorId [string] - Actor id`
   * `phoneNumber [string] - Phone number`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `actorId [string] - Actor id`
       * `phoneNumber [string] - Phone number`


### Remove subscription ###

* **URL**

  `/rpc/subscription/subscription/remove`

* **Method**

  `POST`

* **Data Params**

  **Optional**

   * `subscriptionId [number] - Subscription id`

* **Success Response**

  * **Code:** 200 <br />
    **Content**
       * `subscriptionId [number] - Subscription id`
