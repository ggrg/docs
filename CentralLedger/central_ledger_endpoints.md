# Central Ledger API

The central ledger is a system to record transfers between DFSPs, and to calculate net positions for DFSPs and issue settlement instructions.

- [Data Structures](#data_structures)
	- [Transfer Object](#transfer_object)
	- [Account Object](#account_object)
	- [Notification Object](#notification_object)
	- [Metadata Object](#metadata_object)
	- [Position Object](#position_object)
- [Endpoints](#endpoints)
	- [Transfer Endpoints](#transfer_endpoints)
		- [Prepare a transfer](#prepare_transfer)
		- [Execute a prepared transfer](#execute_transfer)
		- [Get transfer by ID](#get_transfer_by_id)
		- [Get transfer fulfillment](#get_transfer_fulfillment)
		- [Reject transfer](#reject_transfer)
	- [Account Endpoints](#account_endpoints)
		- [Create account](#create_account)
		- [Get account by name](#get_account_by_name)
	- [Other Endpoints](#other_endpoints)
		- [Get ledger metadata](#get_ledger_metadata)
		- [Get net positions](#get_net_positions)
		- [Settle fulfilled transfers](#settle_fulfilled_transfers)
- [Error Information](#error_information)

## Data Structures<a name="data_structures"></a>


### Transfer Object<a name="transfer_object"></a>

A transfer represents money being moved between two DFSP accounts at the central ledger.

The transfer must specify an execution_condition, in which case it executes automatically when presented with the fulfillment for the condition. (Assuming the transfer has not expired or been canceled first.) Currently, the central ledger only supports the condition type of [PREIMAGE-SHA-256](https://interledger.org/five-bells-condition/spec.html#rfc.section.4.1) and a max fulfillment length of 65535.

Some fields are Read-only, meaning they are set by the API and cannot be modified by clients. A transfer object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| id   | URI | Resource identifier |
| ledger | URI | The ledger where the transfer will take place |
| debits | Array | Funds that go into the transfer |
| debits[].account | URI | Account holding the funds |
| debits[].amount | String | Amount as decimal |
| debits[].invoice | URI | *Optional* Unique invoice URI |
| debits[].memo | Object | *Optional* Additional information related to the debit |
| debits[].authorized | Boolean | *Optional* Indicates whether the debit has been authorized by the required account holder |
| debits[].rejected | Boolean | *Optional* Indicates whether debit has been rejected by account holder |
| debits[].rejection_message | String | *Optional* Reason the debit was rejected |
| credits | Array | Funds that come out of the transfer |
| credits[].account | URI | Account receiving the funds |
| credits[].amount | String | Amount as decimal |
| credits[].invoice | URI | *Optional* Unique invoice URI |
| credits[].memo | Object | *Optional* Additional information related to the credit |
| credits[].authorized | Boolean | *Optional* Indicates whether the credit has been authorized by the required account holder |
| credits[].rejected | Boolean | *Optional* Indicates whether credit has been rejected by account holder |
| credits[].rejection_message | String | *Optional* Reason the credit was rejected |
| execution_condition | String | The condition for executing the transfer |
| expires_at | DateTime | Time when the transfer expires. If the transfer has not executed by this time, the transfer is canceled. |
| state | String | *Optional, Read-only* The current state of the transfer (informational only) |
| timeline | Object | *Optional, Read-only* Timeline of the transfer's state transitions |
| timeline.prepared_at | DateTime | *Optional* An informational field added by the ledger to indicate when the transfer was originally prepared |
| timeline.executed_at | DateTime | *Optional* An informational field added by the ledger to indicate when the transfer was originally executed |

### Account Object<a name="account_object"></a>

An account represents a DFSP's position at the central ledger.

Some fields are Read-only, meaning they are set by the API and cannot be modified by clients. An account object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | URI | *Read-only* Resource identifier |
| name | String | Unique name of the account |
| balance | String | *Optional, Read-only* Balance as decimal |
| is_disabled | Boolean | *Optional, Read-only* Admin users may disable/enable an account |
| ledger | URI | *Optional, Read-only* A link to the account's ledger |
| created | DateTime | *Optional, Read-only* Time when account was created |

### Notification Object<a name="notification_object"></a>

The central ledger pushes a notification object to WebSocket clients when a transfer changes state. This notification is sent at most once for each state change.

A notification object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| resource | Object | [Transfer object](#transfer_object) that is the subject of the notification |
| related_resources | Object | *Optional* Additional resources relevant to the event |
| related\_resources.execution\_condition_fulfillment | String | *Optional* Proof of condition completion |
| related\_resources.cancellation\_condition_fulfillment | String | *Optional* Proof of condition completion |

### Metadata Object<a name="metadata_object"></a>

The central ledger will return a metadata object about itself allowing client's to configure themselves properly.

A metadata object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| currency_code | String | Three-letter ([ISO 4217](http://www.xe.com/iso4217.php)) code of the currency this ledger tracks |
| currency_symbol | String | Currency symbol to use in user interfaces for the currency represented in this ledger. For example, "$" |
| ledger | URI | The ledger that generated the metadata |
| urls | Object | Paths to other methods exposed by this ledger. Each field name is short name for a method and the value is the path to that method. |
| precision | Integer | How many total decimal digits of precision this ledger uses to represent currency amounts |
| scale | Integer | How many digits after the decimal place this ledger supports in currency amounts |

### Position Object<a name="position_object"></a>

The central ledger can report the current positions for all registered accounts.

A position object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| account | URI | A link to the account for the calculated position |
| payments | String | Total non-settled amount the account has paid as string |
| receipts | String | Total non-settled amount the account has received as string |
| net | String | Net non-settled amount for the account as string |

## Endpoints<a name="endpoints"></a>

### Transfer Endpoints<a name="transfer_endpoints"></a>

#### Prepare a transfer<a name="prepare_transfer"></a>

This endpoint creates or updates a Transfer object.

```
http://central-ledger/transfers/:id
```

``` http
PUT http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204 HTTP/1.1
Content-Type: application/json
{
  "id": "http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204",
  "ledger": "http://central-ledger",
  "debits": [
    {
      "account": "http://central-ledger/accounts/dfsp1",
      "amount": "50"
    }
  ],
  "credits": [
    {
      "account": "http://central-ledger/accounts/dfsp2",
      "amount": "50"
    }
  ],
  "execution_condition": "cc:0:3:8ZdpKBDUV-KX_OnFZTsCWB_5mlCFI3DynX5f5H2dN-Y:2",
  "expires_at": "2015-06-16T00:00:01.000Z"
}
```

##### Headers
| Field | Type | Description |
| ----- | ---- | ----------- |
| Content-Type | String | Must be set to `application/json` |

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| id | String | A new UUID to identify this transfer |

##### Request body
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Transfer | A [Transfer object](#transfer_object) to describe the transfer that should take place. For a conditional transfer, this includes an execution_condition |

##### Response 201 Created
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Transfer | The newly-created [Transfer object](#transfer_object) as saved |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Transfer | The updated [Transfer object](#transfer_object) as saved |

``` http
HTTP/1.1 201 CREATED
Content-Type: application/json
{
  "id": "http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204",
  "ledger": "http://usd-ledger.example/USD",
  "debits": [
    {
      "account": "http://central-ledger/accounts/dfsp1",
      "amount": "50"
    }
  ],
  "credits": [
    {
      "account": "http://central-ledger/accounts/dfsp2",
      "amount": "50"
    }
  ],
  "execution_condition": "cc:0:3:8ZdpKBDUV-KX_OnFZTsCWB_5mlCFI3DynX5f5H2dN-Y:2",
  "expires_at": "2015-06-16T00:00:01.000Z",
  "state": "proposed"
}
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| UnprocessableEntityError | The provided entity is syntactically correct, but there is a generic semantic problem with it |
| UnsupportedCryptoTypeError | The crypto type specified in the condition is not supported |

#### Execute a prepared transfer<a name="execute_transfer"></a>

Execute or cancel a transfer that has already been prepared. If the prepared transfer has an execution\_condition, you can submit the fulfillment of that condition to execute the transfer. If the prepared transfer has a cancellation\_condition, you can submit the fulfillment of that condition to cancel the transfer.

```http
http://central-ledger/transfers/:id/fulfillment
```

``` http
PUT http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204/fulfillment HTTP/1.1
Content-Type: text/plain
cf:0:_v8
```

##### Headers
| Field | Type | Description |
| ----- | ---- | ----------- |
| Content-Type | String | Must be set to `text/plain` |

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| id | String | Transfer UUID |

##### Request body
| Field | Type | Description |
| ----- | ---- | ----------- |
| Fulfillment | String | A fulfillment in string format |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Fulfillment | String | The fulfillment that was sent |

``` http
HTTP/1.1 200 OK
cf:0:_v8
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| UnprocessableEntityError | The provided entity is syntactically correct, but there is a generic semantic problem with it |
| NotFoundError | The requested resource could not be found |

#### Get a transfer object<a name="get_transfer_by_id"></a>

This endpoint is used to query about the details or status of a local transfer.

``` http
http://central-ledger/transfers/:id
```

```http
GET http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204 HTTP/1.1
```

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| id | String | Transfer UUID |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Transfer | The [Transfer object](#transfer_object) as saved |

``` http
HTTP/1.1 200 OK
{
  "id": "http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204",
  "ledger": "http://usd-ledger.example/USD",
  "debits": [
    {
      "account": "http://usd-ledger.example/USD/accounts/alice",
      "amount": "50"
    }
  ],
  "credits": [
    {
      "account": "http://usd-ledger.example/USD/accounts/bob",
      "amount": "50"
    }
  ],
  "execution_condition": "cc:0:3:8ZdpKBDUV-KX_OnFZTsCWB_5mlCFI3DynX5f5H2dN-Y:2",
  "expires_at": "2015-06-16T00:00:01.000Z",
  "state": "executed",
  "timeline": {
    "proposed_at": "2015-06-16T00:00:00.000Z",
    "prepared_at": "2015-06-16T00:00:00.500Z",
    "executed_at": "2015-06-16T00:00:00.999Z"
  }
}
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| NotFoundError | The requested resource could not be found |

#### Get transfer fulfillment<a name="get_transfer_fulfillment"></a>

This endpoint is used to retrieve the fulfillment for a transfer that has been executed or cancelled.

```http
http://central-ledger/transfers/:id/fulfillment
```

``` http
GET http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204/fulfillment HTTP/1.1
```

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| id | String | Transfer UUID |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Fulfillment | String | The fulfillment for the transfer |

``` http
HTTP/1.1 200 OK
cf:0:_v8
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| NotFoundError | The requested resource could not be found |

#### Reject transfer<a name="reject_transfer"></a>

Reject the transfer with the given message

``` http
http://central-ledger/transfers/:id/rejection
```

``` http
PUT http://central-ledger/transfers/3a2a1d9e-8640-4d2d-b06c-84f2cd613204/rejection HTTP/1.1
Content-Type: text/plain
error happened
```

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| id | String | Transfer UUID |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Rejection | String | An error message in string format |

``` http
HTTP/1.1 200 OK
error happened
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| NotFoundError | The requested resource could not be found |

### Account Endpoints<a name="account_endpoints"></a>

#### Create account<a name="create_account"></a>

Create an account at the ledger

``` http
http://central-ledger/accounts
```

``` http
POST http://central-ledger/accounts HTTP/1.1
Content-Type: application/json
{
  "name": "dfsp1"
}
```

##### Headers
| Field | Type | Description |
| ----- | ---- | ----------- |
| Content-Type | String | Must be set to `application/json` |

##### Request body
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Account | An [Account object](#account_object) to create |

##### Response 201 Created
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Account | The newly-created [Account object](#account_object) as saved |

``` http
HTTP/1.1 201 CREATED
Content-Type: application/json
{
  "id": "http://central-ledger/accounts/dfsp1",
  "name": "dfsp1",
  "created": "2016-09-28T17:03:37.168Z",
  "balance": 1000000,
  "is_disabled": false,
  "ledger": "http://central-ledger"
}
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| RecordExistsError | The account already exists (determined by name) |

#### Get account by name<a name="get_account_by_name"></a>

Get information about an account

``` http
http://central-ledger/accounts/:name
```

``` http
GET http://central-ledger/accounts/dfsp1 HTTP/1.1
```

##### URL Params
| Field | Type | Description |
| ----- | ---- | ----------- |
| name | String | The unique name for the account |

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Object | Account | The [Account object](#account_object) as saved |

``` http
HTTP/1.1 200 OK
Content-Type: application/json
{
  "id": "http://central-ledger/accounts/dfsp1",
  "name": "dfsp1",
  "created": "2016-09-28T17:03:37.168Z",
  "balance": 1000000,
  "is_disabled": false,
  "ledger": "http://central-ledger"
}
```

##### Errors (4xx)
| Field | Description |
| ----- | ----------- |
| NotFoundError | The requested resource could not be found |

### Other Endpoints<a name="other_endpoints"></a>

#### Get ledger metadata<a name="get_ledger_metadata"></a>

Returns metadata associated with the ledger

``` http
http://central-ledger
```

``` http
GET http://central-ledger HTTP/1.1
```

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Metadata | Object | The [Metadata object](#metadata_object) for the ledger |

``` http
HTTP/1.1 200 OK
{
  "currency_code": null,
  "currency_symbol": null,
  "ledger": "http://central-ledger",
  "urls": {
    "health": "http://central-ledger/health",
    "positions": "http://central-ledger/positions",
    "account": "http://central-ledger/accounts/:name",
    "accounts": "http://central-ledger/accounts",
    "transfer": "http://central-ledger/transfers/:id",
    "transfer_fulfillment": "http://central-ledger/transfers/:id/fulfillment",
    "transfer_rejection": "http://central-ledger/transfers/:id/rejection",
    "account_transfers": "ws://central-ledger/accounts/:name/transfers"
  },
  "precision": 10,
  "scale": 2
}
```

#### Get net positions<a name="get_net_positions"></a>

Get current net positions for all accounts at the ledger

``` http
http://central-ledger/positions
```

``` http
GET http://central-ledger/positions HTTP/1.1
```

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| Positions | Array | List of current [Position objects](#position_object) for the ledger |

``` http
HTTP/1.1 200 OK
{
  "positions": [
    {
      "account": "http://central-ledger/accounts/dfsp1",
      "payments": "208461.06",
      "receipts": "0",
      "net": "-208461.06"
    },
    {
      "account": "http://central-ledger/accounts/dfsp2",
      "payments": "0",
      "receipts": "208461.06",
      "net": "208461.06"
    }
  ]
}
```

#### Settle fulfilled transfers<a name="settle_fulfilled_transfers"></a>

Settle all currently fulfilled transfers in the ledger

``` http
http://central-ledger/webhooks/settle-transfers
```

``` http
POST http://central-ledger/webhooks/settle-transfers HTTP/1.1
```

##### Response 200 OK
| Field | Type | Description |
| ----- | ---- | ----------- |
| N/A | Array | List of transfer ids settled for the ledger |

``` http
HTTP/1.1 200 OK
["3a2a1d9e-8640-4d2d-b06c-84f2cd613207", "7e10238b-4e39-49a4-93dc-c8f73afc1717"]
```

## Error Information<a name="error_information"></a>

This section identifies the potential errors returned and the structure of the response.

An error object can have the following fields:

| Name | Type | Description |
| ---- | ---- | ----------- |
| id | String | An identifier for the type of error |
| message | String | A message describing the error that occurred |
| validationErrors | Array | *Optional* An array of validation errors |
| validationErrors[].message | String | A message describing the validation error |
| validationErrors[].params | Object | An object containing the field that caused the validation error |
| validationErrors[].params.key | String | The name of the field that caused the validation error |
| validationErrors[].params.value | String | The value that caused the validation error |
| validationErrors[].params.child | String | The name of the child field |

``` http
HTTP/1.1 404 Not Found
Content-Type: application/json
{
  "id": "InvalidUriParameterError",
  "message": "Error validating one or more uri parameters",
  "validationErrors": [
    {
      "message": "id must be a valid GUID",
      "params": {
        "value": "7d4f2a70-e0d6-42dc-9efb-6d23060ccd6",
        "key": "id"
      }
    }
  ]
}
```
