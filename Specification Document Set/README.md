# Open API for FSP Interoperability Specification
The Open API for FSP Interoperability Specification includes the following documents.

#### General Documents
- Glossary
#### Logical Documents
- Logical Data Model
- Generic Transaction Patterns
- Use Cases
#### Asynchronous REST Binding Documents
- API Definition
- JSON Binding Rules 
- Scheme Rules
#### Data Integrity, Confidentiality, and Non-Repudiation
- PKI Best Practices
- Signature
- Encryption

## API Definition
The **API Definition** document introduces and describes the Open API (Application Programming Interface) for FSP (Financial Service Provider) Interoperability (hereafter cited as "the API"). The purpose of the API is to enable interoperable financial transactions between a Payer (a payer of electronic funds in a payment transaction) located in one FSP (an entity that provides a digital financial service to an end user) and a Payee (a recipient of electronic funds in a payment transaction) located in another FSP. The API does not specify any front-end services between a Payer or Payee and its own FSP; all services defined in the API are between FSPs. FSPs are connected either (a) directly to each other or (b) by a Switch placed between the FSPs to route financial transactions to the correct FSP. 
The transfer of funds from a Payer to a Payee should be performed in near real-time. As soon as a financial transaction has been agreed to by both parties, it is deemed irrevocable. This means that a completed transaction cannot be reversed in the API. To reverse a transaction, a new negated refund transaction should be created from the Payee of the original transaction.  

The API is designed to be sufficiently generic to support both a wide number of use cases and extensibility of those use cases, However, it should contain sufficient detail to enable implementation in an unambiguous fashion.  
Version 1.0 of the API is designed to be used within a country or region; international remittance that requires foreign exchange is not supported. This version also contains basic support for the Interledger Protocol, which will in future versions of the API be used for supporting foreign exchange and multi-hop financial transactions.

This document:
- Defines an asynchronous REST binding of the logical API introduced in Generic Transaction Patterns.
- Adds to and builds on the information provided in Open API for FSP Interoperability Specification. The contents of the Specification are listed in Section **Open API for FSP Interoperability Specification**.