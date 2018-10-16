# DFSP Management

DFSP's can be registered and put on hold in the central directory. Doing so enables and disables the DFPS from conducting trasfers with the central ledger.

These operations are done through (restful API calls to the central directory)[https://github.com/mojaloop/Docs/blob/master/CentralDirectory/central_directory_endpoints.md]

## Add DFSP 
Registers the DFSP with the central directory. 

## Pause DFSP
Not yet implemented. This should cause all calls for that DFSPs users to return "unknown" and all pending transfers for that DFSP to be cancelled at the center. It could be called by a DFSP for itself or a regulator at the center. 

## Unpause the DFSP
Not yet implemented. Would renew normal operations for the DFSP.
