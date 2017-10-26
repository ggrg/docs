
# Bulk Payments

-----

## Bulk Payment Initiation

In the DFSP there should be a web interface available where every user (with certain user rights) of the DFSP can login with user number and PIN and initiate a bulk payment.

When initiating a bulk payment the user should be able to select an account from which the bulk payments will be send.

L1P shall support upload of the bulk file with payments from a web interface. The file format should be .csv. The fields in the file will be:

- Sequence Number (row)
- Identifier
- First Name
- Last Name
- Date of birth
- National id
- Amount

## Maker/Checker

There is a maker/checker concept implemented for bulk payments. Maker and Checker are roles that can be assigned to different users. Maker role is going to upload the file with the bulk payments and checker role is going to initiate the bulk payments.

## Bulk File Verification

All the fields in the bulk file shall be mandatory.

In case the some of the required fields are not valid the funds will not be disbursed to this user.

## Handling Fees

The discriminatory fees should be recorded in the same way as it is done for a regular transaction - different row in the ledger for each payment. There is possibility to configure different fees per different transaction type, so there could be special set of fee configured for the bulk payments.
The rational behind having the fees recorded as a separate line for each transaction is:

- Calculation and record of the discriminatory fees are done within the DFSP and we do not foresee any performance issues to come from that approach.

- The fees must be recorded as a separate row in the ledger

## Re-sending of Funds in Case a Temporary Error is Detected

Upon sending bulk payments the system should detect temporary errors and retry sending of funds again to those user.

Temporary errors could be technical such as missing connectivity or some service is down or non technical such as not enough funds in the account, tier limit is hit, etc.

The system should detect a special case - a user has already a user number but for a service different from mWallet/bank account. In this case the system should notify the user to open a mWallet/bank account.

When initiating a bulk payment the system shall allow entering of the end date/time after which the bulk report will be finalized and no more retries to recover from temporary errors will be done.

The L1P should have some logic for retrying bulk payments which had failed due to temporary errors. There is a configuration on DFSP level for the minimum retry time for bulk payments.

## Out-of Scope Scenarios

The L1P shall reject component transactions where named participants are ineligible to transact.

Rationale: Payments must be subject to fraud and AML/CFT checks, and blocked where the participant is deemed an unacceptable recipient. www.gatesfoundation.org Requirements for a Pro-Poor Interoperability Service for Transfers.

*Currently we don’t have such components in the system to support this scenario.*

## Handling Bulk Payments Transactions

The diagram below illustrates both cases - whether the user has a mwallet account or not.
* In case the user has an existing mwallet account the money will be attempted to be transferred to it.
* In the other case - the user's default DFSP will indicate that there's no mwallet account associated with the given user and therefore a temporary error will be recorded in sending DFSP's database and the user will be notified.

![](./src/bulk_payment_single_record_processing.png)

The following changes have to be implemented:

** Central directory get user API**

Current Request:

    GET http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8088/directory/v1/resources?identifierType=eur&identifier=26547070

Current Response:

    {
      "spspReceiver": "http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:3043/v1"
    }

- To be able to query for many users we should enable posting of multiple 'identifierTypes' and 'identifiers'.
- To support posting to a user number which does not have mWallet/bank account opened, we need to define another 'identifierType' e.g. phone subscribers and to be able to do a query of if. The response shouldn't be a spspServer, but a 'notificationURL'.


** SPSP Protocol**


- Get Payee Details (changes in this API is needed only if we have to compare names in DFSP against names from the uploaded bulk file).

Current Request:

    GET http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8088/spsp/client/v1/query?receiver=http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:3043/v1/receivers/26547070

Current Response:

	{
	  "type": "payee",
	  "name": "bob",
	  "account": "levelone.dfsp1.bob",
	  "currencyCode": "USD",
	  "currencySymbol": "$",
	  "imageUrl": "https://red.ilpdemo.org/api/receivers/bob/profile_pic.jpg"
	}

We have to enable API to be able to query for multiple receivers

** Quote Destination Amount **
This API is needed only if we have to get connector fees.

Current Request:

    GET http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8088/spsp/client/v1/quoteDestinationAmount?receiver=http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:3043/v1/receivers/26547070&destinationAmount=32


Current Response:

    {
      "sourceAmount": "32"
    }

This API should be changed to support multiple receivers/amounts and get back the information for them.

** Setup/Payment **

Current Request:

	POST http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8088/spsp/client/v1/setup
	{
		receiver: "http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:3043/v1/receivers/26547070",
		sourceAccount: "http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8014/ledger/accounts/alice",
		destinationAmount: 33,
		memo: {
			fee: 1,
			transferCode: 'p2p',
			debitName: 'alice',
			creditName: 'bob'
		},
		sourceIdentifier: '85555384'
	}

Current Response:

	{
	  "id": "",
	  "address": "",
	  "destinationAmount": "",
	  "sourceAmount": "",
	  "sourceAccount": "",
	  "expiresAt": "",
	  "data": {
	    "senderIdentifier": ""
	  },
	  "additionalHeaders": "",
	  "condition": ""
	}

This API should be changed to support multiple receivers/amounts and get back the information for them.