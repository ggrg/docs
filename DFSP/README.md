# Overview

## Contents

- [Component Diagram](#component-diagram)
- [Flow Diagrams](#flow-diagrams)
- [Default Ports](#default-ports)
- [Development Environment Setup](#development-environment-setup)


## DFSP Microservices

DFSP functionality includes the following services:

- **dfsp-api** - contains business the logic and exposes it as API
- **[dfsp-directory](directory.md)** - methods related to lookup services, like finding URLs, obtaining lists of districts, towns, participants, etc.
- **[dfsp-identity](identity.md)** - methods for managing identity related data, like sessions, images, PINs, etc.
- **dfsp-ledger** - ledger service will keep account balances and transfers.
- **dfsp-interledger** - service implementing the Interledger protocol
- **[dfsp-notification](notification.md)** - SMS, email and smart app notifications
- **[dfsp-rule](rule.md)** - fees, limits and other rules, like checking where a voucher can be used. AML functionality.
- **[dfsp-subscription](subscription.md)** - methods related to managing the data associated to a subscription, but not related to accounts.
- **[dfsp-transfer](transfer.md)** - methods that relate to movement of money between accounts
- **[dfsp-account](account.md)** - methods that affect ledger accounts, like creating new ones or relations between account and other data like NFC, biometric, float, phone, signatories, etc.
- **[dfsp-admin](admin.md)** - web interface for DFSP.
- **[dfsp-mock](mock.md)** - mocking of external to DFSP services.

## Component Diagram

![microservices component diagram](./microServices.png)

## Flow Diagrams

### Push Transfer Sequence Diagram

![Push transfer sequence diagram](./transfer.push.create.png)

### Bulk Transfer Sequence Diagram

![Bulk transfer sequence diagram](./transfer.bulk.create.png)

## Default Ports

Each service has default ports in the development environment. Below you can find these defaults for each project.

| project                                                                       | debug console    |  httpserver port | API
| ---------------                                                               | ------------     | ---------------  | -----------
| [dfsp-account](https://github.com/mojaloop/dfsp-account)               | 30009            | 8009             |
| [dfsp-api](https://github.com/mojaloop/dfsp-api)                       | 30010            | 8010             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8010/documentation)
| [dfsp-directory](https://github.com/mojaloop/dfsp-directory)           | 30011            | 8011             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8011/documentation)
| [dfsp-identity](https://github.com/mojaloop/dfsp-identity)             | 30012            | 8012             |
| [dfsp-interledger](https://github.com/mojaloop/dfsp-interledger)       | 30013            | 8013             |
| [dfsp-ledger](https://github.com/mojaloop/dfsp-ledger)                 | 30014            | 8014             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8014/documentation)
| [dfsp-notification](https://github.com/mojaloop/dfsp-notification)     | 30015            | 8015             |
| [dfsp-rule](https://github.com/mojaloop/dfsp-rule)                     | 30016            | 8016             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8016/documentation)
| [dfsp-subscription](https://github.com/mojaloop/dfsp-subscription)     | 30017            | 8017             |
| [dfsp-transfer](https://github.com/mojaloop/dfsp-transfer)             | 30018            | 8018             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8018/documentation)
| [dfsp-ussd](https://github.com/mojaloop/dfsp-ussd)                     | 30019            | 8019             | [swagger](http://ec2-35-163-231-111.us-west-2.compute.amazonaws.com:8019/documentation)
| [dfsp-admin](https://github.com/mojaloop/dfsp-admin)                   | 30020            | 8020             |
| [dfsp-mock](https://github.com/mojaloop/dfsp-mock)                     |                  | 8021             |

## Development Environment Setup

See [Development environment setup](development.md)
