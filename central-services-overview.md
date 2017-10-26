# Central Services Overview

The central services stack provides shared functions that allow scheme participants and Digital Financial Service Providers (DFSPs) to execute a several actions using a consistent communication channel. In addition, the functions of the central services promote overall health of the scheme, allowing DFSPs to participate with confidence and reliability.

The information in this section summarizes the various services that the central services stack offers:

## Directory

The central directory is a set of services that allows DFSPs to register and retrieve scheme identifiers. The scheme identifier can be leveraged by DFSPs for end-user discovery. he services, APIs and endpoints enable:

- Registering a DFSP
- Adding an end user
- Retrieving an end user

To view the references and available endpoints, please see the [Central Directory repository](https://github.com/mojaloop/central-directory).

## Ledger

The central ledger is a set of services that facilitate clearing and settlement of transfers between DFSPs, including the following functions:

- Brokering real-time messaging for funds clearing
- Maintaining net positions for a deferred net settlement
- Propagating scheme-level and off-transfer fees

To view the references and available endpoints, please see the [Central Ledger repository](https://github.com/mojaloop/central-ledger).

## Fraud Sharing - *in-progress*

The fraud sharing service offers participating DFSPs an avenue to share end user and transactional information to help promote overall health of the scheme via fraud prevention, focusing on:

- Sharing end user and transaction information
- Enabling DFSPs to prevent fraud, not the scheme

The service is current being delivered and will be available as an initial product offering.

## Forensic Logging - *in-progress*

The forensic logging solution allows information required to ensure the confidentiality and integrity of the overall central services stack. Events are captured, preserved and made available to authorized inquiries. Functions of the logging mechanism include:

- Distributed implementation and log creation/storage
- Centralized Key Management Service (KMS)
- Cryptographic protection of data in-transit (encryption) including proof of integrity (signing)
- Removes a single point of failure

The service is current being delivered and will be available as an initial product offering.

## Authentication

Currently the centralized services leverage basic authentication to secure interactions. A basic authentication solution was chosen to ensure a demonstration would be available while allowing adaptations for specific integrations. This solution is fully compatible with an HTTPS-based (TLS) environment.
