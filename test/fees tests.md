# Fee tests
Below we list the equivalence classes that make of the test combinations in the test matrix.

## Variations

### Fee Source
- Sender fee
- Receiver fee
- Agent cash-out fee
- Agent cash-in fee
- Central fee

### Path for transfer
- Cross-DFSP
- Same DFSP (should not apply center fee)

### Configure Amount
- Stair-step: flat fee plus percent for range
- Zero

## Test Matrix 
Using pair combinations of the variations we get a matrix like this:

| Path | Source | Receiver | Center| Agent Cash In |  Agent Cash Out |
|------| -------|----------|-------|---------------| --------------- |
|Cross-DFSP |  0 |  Stair-step |  0 |  Stair-step |  0 |
|Cross-DFSP |  Stair-step |  0 |  Stair-step |  0 |  Stair-step |
|Same-DFSP |  Stair-step |  Stair-step |  0 |  0 |  Stair-step |
|Same-DFSP |  0 |  0 |  Stair-step |  Stair-step |  0 |
|* |  0 |  * |  Stair-step |  0 |  Stair-step |
|* |  Stair-step |  * |  0 |  Stair-step |  0 |
|Cross-DFSP |  * |  * |  * |  Stair-step |  Stair-step |
|* |  * |  * |  * |  0 |  0 |

\* value doesn't matter

## Validations
For each variation verify that the fees can be:
- Configured
- Shown to the sender (it's enough to check the quote return from the scheme adapter)
- Deducted from the transfer
- Itemized for settlement (for these last two it's enough to check central ledger)