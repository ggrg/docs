# Docs Overview
The _Docs_ repository documents the overall architecture, component design, message flow, high level tests and an overview of the Mojaloop software. 

Individual repositories in the [mojaloop GitHub organization](https://github.com/mojaloop/) each describe component-specific details including source and APIs.

For more information on Mojaloop, see the https://mojaloop.io

New developers, see the [contributors guide](https://github.com/mojaloop/mojaloop/blob/master/contribute.md) for onboarding materials.

## Mojaloop Services
The following architecture diagram shows the Mojaloop services:

![Mojaloop Services](./Wiki/Basic%20Overview.png)

### DFSP Service
The DFSP code is an example implementation of a mobile money provider. Customers connect to it from their mobile feature phones using Unstructured Supplementary Service Data (USSD). USSD is a Global System for Mobile (GSM) communication technology that is used to send text between a mobile phone and an application program in the network, allowing users to create accounts, send money, and receive money.

[DFSP Documentation](./DFSP)

### Level One Client Service
The client service connects a DFSP to other other DFSPs and the central services. It has a few simple interfaces to connect to a DFSP for account holder lookup, payment setup, and ledger operations. The level one client can be hosted locally by the DFSP or in a remote data center such as Amazon.

### Central Services
The central services are a collection of separate services that help the DFSPs perform operations on the network.

- The [Central Directory Service](./CentralDirectory) determines which DFSP handles a user's accounts.
- The [Central Ledger Service](./CentralLedger) handles clearing and settlement.
- The [Central Rules Service](./CentralRules) sets policy across the system.
- The [Fraud service](https://github.com/mojaloop/central-fraud-sharing) aids DFPS in identifying suspicious behavior.

## End-to-End Scenarios
The aforementioned individual services can't alone describe how key scenarios work across the system. Therefore, for each of the [Mojaloop Scenarios](https://github.com/mojaloop/mojaloop/contribute/Scenarios.md), we provide a technical walk through.

1. Send Money to Anyone: [scenario](https://github.com/mojaloop/Docs/blob/master/scenarios.md#send-money-to-anyone),  [walkthrough](./LevelOneClient/scenarios/Send%20Payment.md)
2. Buy Goods [scenario](https://github.com/mojaloop/Docs/blob/master/scenarios.md#buy-goods---pending-transactions), [message flow](./DFSP/PendingTransactions/README.md)
3. Bulk Payment [scenario](https://github.com/mojaloop/Docs/blob/master/scenarios.md#bulk-payments), [message flow](./DFSP/BulkPayment/README.md)

## System-wide Testing
Individual services have their own tests, but the [testing strategy](https://github.com/mojaloop/mojaloop/blob/master/contribute/Testing-strategy.md) also includes the following system-wide tests:

- [Scenario testing](https://github.com/mojaloop/Docs/blob/master/test/end-to-end/readme.md)
- [End-to-end functional testing](https://github.com/mojaloop/interop-functional-tests/blob/master/README.md)
- [Performance testing](https://github.com/mojaloop/Docs/blob/master/test/performance/Performance%20Testing%20Summary.pdf)
- [Resilience Modeling and Analysis (RMA)](https://github.com/mojaloop/Docs/blob/master/test/RMA.md)
- Threat Modeling

## Related Projects
The [Interledger Protocol Suite](https://interledger.org/) (ILP) is an open and secure standard that enables DFSPs to settle payments with minimal _counter-party risk_ (the risk you incur when someone else is holding your money). With ILP, you can transact across different systems with no chance that someone in the middle disappears with your money. Mojaloop uses the Interledger Protocol Suite for the clearing layer. For an overview of how it works, see the [Clearing Architecture Documentation](https://github.com/mojaloop/Docs/blob/master/ILP/README.md).

## About This Document

This document is a work in progress; not all sections are updated to the latest developments in the project. Sections that are known to be out of date are marked as follows:

> ***OUT OF DATE STARTS HERE***

Any text in this area is considered "out of date." It may reflect earlier versions of the technology, outdated terminology use, or sections that are poorly phrased and edited.

> ***OUT OF DATE ENDS HERE***
