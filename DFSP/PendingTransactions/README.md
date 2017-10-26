# Pending Transaction

See [Scenario definition](https://github.com/mojaloop/Docs/blob/master/scenarios#buy-goods---pending-transactions)


#### Assumptions

1. The invoice will be created in the merchant's DFSP. It will be associated with an account.
2. After the invoice is created in the merchant's DFSP, a notification with the invoice reference will be send to the primary client DFSP.
3. The client DFSP will stored the reference (full URL) to the merchant's invoice.
4. The invoice reference in the client DFSP will not be associated with any client's account; thus the client can choose the account from which he is going to pay the invoice.
5. As a consequence of the above, in case the client has accounts in more than one DFSP, he will receive the invoice notification only in his primary DFSP.
From the USSD interface he will be able to pay the invoice only from his primary DFSP.


**Note:** '**dfsp1**' is referred to as client DFSP (paying the invoice) and '**dfsp2**' as the merchant DFSP (issuing the invoice).

## I.  Get Sender Details  ##

![](./getSenderDetails.png)

[DFSP USSD -> DFSP API]()

**1.1 Get Payee**

This method is not exposed as a DFSP Api rest route as it is not meant to be called directly from external systems.

*Request:*

    {
        "identifier": "78956562"
    }

*Response:*
    200 OK

    {
        "spspReceiver": "http://dfsp2-spsp-server:3043/v1"
    }

- spspReceiver - the base url of sender's spsp server

[DFSP API -> Directory Gateway]()

**1.2 User Lookup Request**

*Request:*

    GET http://central-directory/resources?identifier=78956562&identifierType=eur


*Response:*

    200 OK

    {
        "spspReceiver": "http://dfsp2-spsp-server:3043/v1",
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }


- spspReceiver - the base url of sender's spsp server

[Directory Gateway -> Central Directory]()

**1.3 User Lookup Request**

*Request:*

    GET http://central-directory/resources?identifier=78956562&identifierType=eur


*Response:*

    200 OK

    {
        "spspReceiver": "http://dfsp2-spsp-server:3043/v1",
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }


- spspReceiver - the base url of sender's spsp server

[Central Directory -> Central User Registry]()

**1.4 User Lookup Request**

-- to be filled in

[DFSP API -> SPSP Client Proxy]()

**1.5 Query User Request**


*Request:*

    GET http://dfsp1.spsp-client-proxy/spsp.client/v1/query?receiver=http://dfsp2-spsp-server:3043/v1/receivers/78956562

*Response:*

    200 OK

    {
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }

[SPSP Client Proxy -> SPSP Client]()

**1.6 Query User Request**

*Request:*

    GET http://dfsp1.spsp-client-proxy/spsp.client/v1/query?receiver=http://dfsp2-spsp-server:3043/v1/receivers/78956562

*Response:*

    200 OK

    {
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }

[SPSP Client -> SPSP Server]()

**1.7 Query User Request**

*Request:*

    GET http://dfsp2-spsp-server:3043/v1/receivers/78956562

*Response:*

    200 OK

    {
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }


[SPSP Server -> SPSP Server Backend]()

**1.8 Query User Request**

-- to be filled in

[SPSP Server Backend -> DFSP Api]()

**1.9 Query User Request**

*Request:*

    GET http://dfsp2-api:8010/v1/receivers/78956562

*Response:*

    200 OK

    {
        "type": "payee",
        "name": "bob",
        "account": "levelone.dfsp2.bob",
        "currencyCode": "USD",
        "currencySymbol": "$",
        "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
    }

## II.  Quote Source/Destination  ##

![](./quote.png)


###  [ DFSP API -> SPSP CLIENT Proxy ]() ###


**2.1 quoteDestination Method**

200 OK

*Request:*

    GET http://dfsp1.spsp-client/quoteDestinationAmount/

    {
        "receiver": "http://ilp-spsp-server:3043/v1/receivers/16023825",
        "destinationAmount": "10"
    }


*Response:*

    {
        "sourceAmount": "10"
    }


###  [ SPSP CLIENT Proxy -> SPSP CLIENT ]() ###


**2.2 quoteDestination Method**

-- to be filled in

###  [  SPSP Client -> ILP Connector ]() ###


**2.4 Create Invoice Notification Method**


This method will be used for communication between SPSP Client and ILP Connector components.

*Request:*


    -- to be filled in


*Response:*


    -- to be filled in


## III.  Invoice Creation  ##

![](./createInvoice.png)

### [DFSP USSD -> DFSP API]()

**3.1 Create Invoice Method**

*Request:*

    POST http://dfsp-api/merchantInvoice
    {
      account: 'merchant.account',
      name: 'Merchant name',
      currencyCode: 'USD',
      currencySymbol: '$',
      amount: 100,
      userNumber: 'client.user.number',
      spspServer: 'client.spspServer',
      invoiceInfo: 'invoice info'
    }


*Response:*

    201 Created

- account - merchant's ledger account. e.g. http://dfsp-ledger/ledger/accounts/merchant
- userNumber - client's user number. e.g. '26547070'
- spspServer - baseUrl to client's spsp server. e.g. http://sender-spsp-server/v1


###  [ DFSP API -> SPSP CLIENT Proxy ]() ###


**3.2 Create Invoice Notification Method**


*Request:*

    POST http://dfsp2.spsp-client/invoices/
    {
          "invoiceId":"12345",
          "submissionUrl": "dfsp1.spsp-server/v1/invoices",
        "senderIdentifier": "client.user.number",
          "memo":"Invoice from merchant for 100 USD"
    }


*Response:*

    201 Created


- invoiceId - Id of the invoice that has been generated and stored in the merchant's DFSP.
- submissionUrl - URL to client DFSP. Since this message is send from DFSP-Transfer service to SPSP Client Proxy Service, the receiver service has to know which targer SPSP server to contact. This information should be stored in the central directory and can be mapped from a user number.
- memo - field that is going to be displayed on the USSD menu under the 'pending transaction section

###  [ SPSP CLIENT Proxy -> SPSP CLIENT ]() ###


**3.3 Create Invoice Notification Method**

-- to be filled in

###  [  SPSP Client -> SPSP SERVER ]() ###


**3.4 Create Invoice Notification Method**


This method will be used for communication between SPSP Client and SPSP Server components.

*Request:*


    POST http://dfsp1.spsp-server/receiver/invoice/
    {
          "invoiceUrl":"http://dfsp2.spsp-server/invoice/12345",
        "senderIdentifier": "client.user.number",
          "memo":"Invoice from merchant for 100 USD"
    }


*Response:*


    201 Created


- invoiceUrl - full URL to the invoice which is generated and stored in the merchant's DFSP.
- memo - field that is going to be displayed on the USSD menu under the 'pending transaction section


###  [  SPSP SERVER -> SPSP SERVER BACKEND ]() ###


**3.5 Create Invoice Notification Method**

-- to be filled in

###  [ SPSP Server Backend -> DFSP API ]() ###


**3.6 Create Invoice Notification Method**


This method will be invoked from SPSP Server and will be used to create invoice reference the 'DFSP Logic'.


*Request:*

    POST http://dfsp1.dfsp-api/receiver/invoice/

    {
        "invoiceUrl":"http://dfsp2.spsp-server/invoice/12345",
        "senderIdentifier": "client.user.number",
          "memo":"Bolagi Shop $5.00"
    }

*Response:*


    201 Created


- invoiceUrl - full URL to the invoice which is generated and stored in the merchant's DFSP.
- memo - field that is going to be displayed on the USSD menu under the 'pending transaction section



## IV. Get Invoice Details   ##

![](./getInvoiceDetails.png)

###  [ SPSP CLIENT PROXY / SPSP CLIENT ](https://github.com/mojaloop/ilp-spsp-client-rest) ###


**4.1 Get Invoice Details**

Get Invoice details will be done by using the already defined method [GET /v1/query API](https://github.com/mojaloop/ilp-spsp-client-rest/blob/master/README.md#get-v1query).



*Request:*



    GET http://dfsp1.spsp-clinet/invoice?invoiceUrl=http://dfsp2.spsp-server/invoice/12345


*Response:*

    200 OK

    {
      "account": "dfsp2.bob.dylan.account",
      "name":"Bob Dylan",
      "currencyCode": "USD",
      "currencySymbol": "$",
      "amount": "10.40",
      "fee":"2.4",
      "status": "unpaid",
      "invoiceInfo": "https://www.example.com/gp/your-account/order-details?ie=UTF8&orderID=111-7777777-1111111"
    }


The following changes will be introduced:

- Add the invoiceUrl as request parameter, since this API is used between DFSP-Transfer and SPSP Client component. After that the SPSP client component has to have the URL to the merchant DFSP where the invoice is stored.
- type field is removed. No need of such field, because the request is for invoice.
- Add the field 'name' - this is the name of the merchant that has issued the invoice.


###  [ SPSP SERVER ](https://github.com/mojaloop/ilp-spsp-server) ###

**4.2 Get Invoice Details**


Get Invoice details in SPSP server will be done by using the already defined method [GET invoice](https://github.com/mojaloop/ilp-spsp-server/blob/master/README.md#invoice).


*Request:*


    GET http://dfsp2.spsp-server/invoice/12345


*Response:*

    200 OK

    {
      "account": "dfsp2.bob.dylan.account",
      "name":"Bob Dylan",
      "currencyCode": "USD",
      "currencySymbol": "$",
      "amount": "10.40",
      "status": "unpaid",
      "invoiceInfo": "https://merchant-website.example/gp/your-account/order-details?ie=UTF8&orderID=111-7777777-1111111"
    }

The following changes will be introduced:


- type field is removed. No need of such field, because the request is for invoice.
- Add the field 'name' - this is the name of the merchant that has issued the invoice.
- Remove field paymentURL - we already have an account field



###  [ SPSP Server Backend / DFSP API ](https://github.com/mojaloop/dfsp-api) ###

**4.3 Get Invoice Details**

The following new method will be implemented in DFSP API. SPSP Server will call this new method to obtain information about an invoice from the 'DFSP Logic'.

*Request:*

    GET http://dfsp2.dfsp-api/invoice/12345


*Response:*

    200 OK

    {
      "account": "dfsp2.bob_dylan.account",
      "name":"Bob Dylan",
      "currencyCode": "USD",
      "currencySymbol": "$",
      "amount": "10.40",
      "status": "unpaid",
      "invoiceInfo": "https://merchant-website.example/gp/your-account/order-details?ie=UTF8&orderID=111-7777777-1111111"
    }



## V. Invoice Payment ##

![](./payment.png)

###  [ DFSP API -> SPSP CLIENT Proxy ]() ###


**5.1 Invoice Payment Method**


*Request:*

    PUT  http://dfsp1.spsp-client-proxy/spsp/client/v1/payments/{uuid}

        {
            "sourceIdentifier": "65144444",
            "sourceAccount": "http://dfsp1-ledger/ledger/accounts/bob",
            "receiver": "http://ilp-spsp-server/v1/receivers/92806391",
            "destinationAmount": "17",
            "currency": "USD",
            "fee": 0,
            "memo": {
                "fee": 0,
                "transferCode": "invoice",
                "debitName": "bob dylan",
                "creditName": "alice cooper"
            }
        }


*Response:*

    200 OK

    {
        "receiver": "http://ilp-spsp-server/v1/receivers/92806391",
        "sourceAccount": "http://spsp/ilp/ledger/v1/accounts/bob",
        "destinationAmount": "17.00",
        "memo": "{\"fee\":0,\"transferCode\":\"invoice\",\"debitName\":\"bob dylan\",\"creditName\":\"alice cooper\",\"debitIdentifier\":\"65144444\"}",
        "sourceIdentifier": "65144444",
        "sourceAmount": "17.00",
        "fulfillment": "hi8Rtk8WiOQkwv5bpeXrSoRj41bPXR8c3hfn5i_6zyQ",
        "status": "executed"
    }


###  [ SPSP CLIENT PROXY -> SPSP CLIENT ](https://github.com/mojaloop/ilp-spsp-client-rest) ###

**5.2 Invoice Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ SPSP CLIENT -> ILP LEDGER ADAPTER ](https://github.com/mojaloop/interop-ilp-ledger) ###

**5.3 Prepare Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP LEDGER ADAPTER -> DFSP Ledger ](https://github.com/mojaloop/dfsp-ledger) ###

**5.4 Prepare Payment**

PUT http://dfsp-ledger/ledger/transfers/{uuid}

*Request:*

    {
        "id": "78311ff6-377e-4f18-8ad2-a919d4b735b1",
        "ledger": "http://spsp-server-backend/ilp/ledger/v1",
        "debits": [
        {
            "account": "http://spsp-server-backend/ilp/ledger/v1/accounts/dfsp1-testconnector",
            "amount": 10,
            "authorized": true,
            "memo": {
            "source_transfer_ledger": "levelone.ist.",
            "source_transfer_id": "7df88b8a-971e-4c95-8402-35196f16855a",
            "source_transfer_amount": "1000"
            }
        }
        ],
        "credits": [
        {
            "account": "http://spsp-server-backend/ilp/ledger/v1/accounts/PerfTest3",
            "amount": 10,
            "memo": {
            "ilp": "AYIBhgAAAAAAAAPoOmxldmVsb25lLmRmc3AxLlBlcmZUZXN0My5OdWlsRldUajNOOEs2dU0zRUprM25iZFdiX01LQkpwa1GCAT9QU0svMS4wCk5vbmNlOiBremE3cjlzaVFxLVpVQjJfaVphUTNBCkVuY3J5cHRpb246IG5vbmUKUGF5bWVudC1JZDogN2ZmZWMwNDMtYjA4Mi00OTExLWI0YjktNDhjYTczYzdiZjQzCgpDb250ZW50LUxlbmd0aDogMTM0CkNvbnRlbnQtVHlwZTogYXBwbGljYXRpb24vanNvbgpTZW5kZXItSWRlbnRpZmllcjogMjk5OTk4MDEKCiJ7XCJmZWVcIjowLFwidHJhbnNmZXJDb2RlXCI6XCJwMnBcIixcImRlYml0TmFtZVwiOlwiRGF2aWQgV2FybmVyXCIsXCJjcmVkaXROYW1lXCI6XCJUZWRkeSBEdW5jYW5cIixcImRlYml0SWRlbnRpZmllclwiOlwiMjk5OTk4MDFcIn0iAA"
            }
        }
        ],
        "execution_condition": "ni:///sha-256;ajsbKuxey2ZYhT9LUzUcz1ccczwIhoYfgrGbfuzy-NA?fpt=preimage-sha-256&cost=32",
        "expires_at": "2017-04-28T15:42:55.294Z"
      }

*Response:*

    200 OK

    {
        "id": "f251d2b2-d619-4c22-adaa-d0cc1c585999",
        "ledger": "http://spsp-server-backend/ilp/ledger/v1",
        "debits": [
        {
            "account": "http://spsp-server-backend/ilp/ledger/v1/accounts/bob",
            "amount": 11,
            "authorized": true
        }
        ],
        "credits": [
        {
            "account": "http://spsp-server-backend/ilp/ledger/v1/accounts/dfsp2-testconnector",
            "amount": 11,
            "memo": {
            "ilp": "AYIBgQAAAAAAAARMNGxldmVsb25lLmRmc3AxLm1lci5UQzFROHVYUllOOFpSNnJxc29yQXo0VExCWEEwdGFxSGeCAUBQU0svMS4wCk5vbmNlOiBrQVJ5eEdmdkpIeWVEWG92RVBEanB3CkVuY3J5cHRpb246IG5vbmUKUGF5bWVudC1JZDogZjI1MWQyYjItZDYxOS00YzIyLWFkYWEtZDBjYzFjNTg1OTk5CgpDb250ZW50LUxlbmd0aDogMTM1CkNvbnRlbnQtVHlwZTogYXBwbGljYXRpb24vanNvbgpTZW5kZXItSWRlbnRpZmllcjogOTI4MDYzOTEKCiJ7XCJmZWVcIjowLFwidHJhbnNmZXJDb2RlXCI6XCJpbnZvaWNlXCIsXCJkZWJpdE5hbWVcIjpcImFsaWNlIGNvb3BlclwiLFwiY3JlZGl0TmFtZVwiOlwibWVyIGNoYW50XCIsXCJkZWJpdElkZW50aWZpZXJcIjpcIjkyODA2MzkxXCJ9IgA"
            }
        }
        ],
        "execution_condition": "ni:///sha-256;xQxWWKWXGw7JaYI62rZ5uu3mXLAnjf2yJbrtC3Xv4Sk?fpt=preimage-sha-256&cost=32",
        "expires_at": "2017-04-28T15:55:16.421Z"
      }

###  [ILP LEDGER ADAPTER -> ILP CONNECTOR ](https://github.com/interledger/ilp-connector) ###

**5.5 Prepare Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP CONNECTOR -> CENTRAL LEDGER ](https://github.com/mojaloop/central-ledger) ###

**5.6 Prepare Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP CONNECTOR -> ILP LEDGER ADAPTER ](https://github.com/mojaloop/interop-ilp-ledger) ###

**5.7 Prepare Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP LEDGER ADAPTER  -> DFSP LEDGER ](https://github.com/mojaloop/dfsp-ledger) ###

**5.8 Prepare Payment**


*Request:*

    PUT http://dfsp-ledger/ledger/transfers/{uuid}
    {
        "uuid": "2527962e-5bbd-460e-8945-154a34f17dba",
        "debitAccount": "bob",
        "debitMemo": {},
        "creditAccount": "dfsp1-testconnector",
        "creditMemo": {
            "ilp_header": {
                "account": "levelone.dfsp2.alice.~psk.UZVSWwsy6ww.MFsvYpK_6SY5BpNLznWs8g.2527962e-5bbd-460e-8945-154a34f17dba",
                "amount": "2.00",
                "data": {
                    "data": {
                        "memo": "{\"fee\":0,\"transferCode\":\"invoice\",\"debitName\":\"bob dylan\",\"creditName\":\"alice cooper\"}",
                        "senderIdentifier": "00427080"
                    },
                    "expires_at": "2017-04-25T17:32:48.384Z"
                }
            }
        },
        "amount": 2,
        "executionCondition": "ni:///sha-256;C2EmAmpD_dylQ8iiI4S-afyvxINo-TRomDJI5tgc-0Y?fpt=preimage-sha-256&cost=32",
        "authorized": true,
        "expiresAt": "2017-04-25T17:32:48.384Z"
    }

*Response:*

    200 OK

     {
        "id": "http://spsp/ledger/transfers/2527962e-5bbd-460e-8945-154a34f17dba",
        "ledger": "http://spsp/ledger",
        "debits": [{
            "account": "http://spsp/ledger/accounts/bob",
            "memo": {},
            "amount": "2.00",
            "authorized": true
        }],
        "credits": [{
            "account": "http://spsp/ledger/accounts/dfsp1-testconnector",
            "memo": {
                "ilp_header": {
                    "account": "levelone.dfsp2.alice.~psk.UZVSWwsy6ww.MFsvYpK_6SY5BpNLznWs8g.2527962e-5bbd-460e-8945-154a34f17dba",
                    "amount": "2.00",
                    "data": {
                        "data": {
                            "memo": "{\"fee\":0,\"transferCode\":\"invoice\",\"debitName\":\"bob dylan\",\"creditName\":\"alice cooper\"}",
                            "senderIdentifier": "00427080"
                        },
                        "expires_at": "2017-04-25T17:32:48.384Z"
                    }
                }
            },
            "amount": "2.00"
        }],
        "execution_condition": "ni:///sha-256;C2EmAmpD_dylQ8iiI4S-afyvxINo-TRomDJI5tgc-0Y?fpt=preimage-sha-256&cost=32",
        "cancellation_condition": null,
        "state": "prepared",
        "expires_at": "2017-04-25T17:32:48.384Z"
 }


###  [ILP LEDGER ADAPTER  -> SPSP SERVER](https://github.com/mojaloop/ilp-spsp-server) ###

**5.9 Prepare Payment**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in


###  [SPSP SERVER -> SPSP SERVER BACKEND](https://github.com/mojaloop/interop-spsp-backend-services) ###

**5.10 Execute Payment Notify**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [SPSP SERVER BACKEND -> DFSP API ](https://github.com/mojaloop/dfsp-api) ###

**5.11 Execute Payment Notify**


*Request:*

    PUT http://dfsp-api/receivers/invoices/{invoiceId}/payments/{paymentid}

    {
        "destinationAmount": "1200",
        "memo": "\"{\\\"fee\\\":0,\\\"transferCode\\\":\\\"invoice\\\",\\\"debitName\\\":\\\"alice cooper\\\",\\\"creditName\\\":\\\"mer chant\\\",\\\"debitIdentifier\\\":\\\"92806391\\\"}\"",
        "status": "proposed",
        "transferId": "883bb6ba-f425-4bad-80d0-8588f0c192de",
        "invoiceId": "16",
        "paymentid": "ce8dfee1-f6be-4b89-a44b-06fbd941e0b2"
  }

*Response:*

    200 OK {}


###  [SPSP SERVER -> ILP-LEDGER_ADAPTER ](https://github.com/mojaloop/interop-ilp-ledger) ###

**5.12 Execute Payment Request**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP-LEDGER_ADAPTER -> DFSP LEDGER](https://github.com/mojaloop/dfsp-ledger) ###

**5.13 Execute Payment Request**


*Request:*

    PUT http://dfsp-ledger/ledger/transfers/{transferId}/fulfillment

    {
        "transferId": "6a4c78f4-cc2f-488f-b04d-26b71c92962a",
        "fulfillment": "oCKAIIYvEbZPFojkJML-W6Xl60qEY-NWz10fHN4X5-Yv-s8k",
        "condition": "ni:///sha-256;sbawjV8idAMItrwviBMq4zMOkuo_lRLNMm1KPPVFM2A?fpt=preimage-sha-256&cost=32"
    }

*Response:*

    Returns transfer fulfillment.

    200 OK

    "oCKAIIYvEbZPFojkJML-W6Xl60qEY-NWz10fHN4X5-Yv-s8k"


###  [ILP-LEDGER_ADAPTER -> ILP-CONNECTOR](https://github.com/interledgerjs/ilp-connector) ###

**5.14 Execute Payment Notification**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP-CONNECTOR -> CENTRAL LEDGER ](https://github.com/mojaloop/central-ledger) ###

**5.15 Execute Payment Request**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP-CONNECTOR -> ILP LEDGER ADAPTER](https://github.com/mojaloop/interop-ilp-ledger) ###

**5.16 Execute Payment Request**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in

###  [ILP LEDGER ADAPTER -> DFSP LEDGER ](https://github.com/mojaloop/dfsp-ledger) ###

**5.17 Execute Payment Request**


*Request:*

    PUT http://dfsp-ledger/ledger/transfers/{transferId}/fulfillment

    {
        "transferId": "6a4c78f4-cc2f-488f-b04d-26b71c92962a",
        "fulfillment": "oCKAIIYvEbZPFojkJML-W6Xl60qEY-NWz10fHN4X5-Yv-s8k",
        "condition": "ni:///sha-256;sbawjV8idAMItrwviBMq4zMOkuo_lRLNMm1KPPVFM2A?fpt=preimage-sha-256&cost=32"
    }

*Response:*

    Returns transfer fulfillment.

    200 OK

    "oCKAIIYvEbZPFojkJML-W6Xl60qEY-NWz10fHN4X5-Yv-s8k"

###  [ILP LEDGER ADAPTER -> SPSP CLIENT ](https://github.com/mojaloop/ilp-spsp-client-rest) ###

**5.18 Execute Payment Notification**


*Request:*

    -- to be filled in

*Response:*

    --  to be filled in
