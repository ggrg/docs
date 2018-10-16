# Central Ledger

## Component Architecture

![Central Ledger Block Diagram](./central_ledger_block_diagram.png)

## Transfer/Fulfillment Flow
![Transfer/Fulfillment sequence diagram](./central_ledger_sequence_transferfulfillment.png)
### Note 
Only transfers where a Payer’s currency is the same as a Payee’s currency are operational in this release; i.e., even though multi-currency is supported, cross-currency is not supported at this time. The Cross-currency transfers use case is currently being investigated.

## Settlement Flow
![Settlement sequence diagram](./central_ledger_sequence_settlement.png)

## Endpoints
[Endpoints documentation](./central_ledger_endpoints.md)
