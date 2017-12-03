# User Discovery

In order for a sender to make a payment to a receiver they must "discover" some things about the receiver, such
as their ILP address and the currency of their account.

Following this, further information may be required by the sending system such as the full name, public key or
even a photograph of the receiver for validation by the sender.

## Flow

1. The sender (End User) has an identifier for the receiver such as an account number, mobile number, or national identity number.
2. The sending system (DFSP) uses this identifier to discover the information required to:   
  a. Show appropriate info on the phone of the sender (name of receiver, currency code of receiving account etc.)  
  b. Initiate the [Interledger Protocol Suite (ILP)](https://interledger.org/) transfer (ILP address of receiving account, amount, condition etc.)  
  c. Get a quote for the transfer.
3. The sender confirms the transfer and initiates it by way of the sending DFSP.

## Design Considerations

1. There are a wide variety of identifiers that may be used to initiate the discovery process.
2. A lot of the data required is gathered during the Simple Payment Setup Protocol (SPSP).
3. The deployment scenarios will differ and as such the registries of identifiers will have different architectures
(for example, distributed versus centralized).

## Service Discovery vs Data Discovery

Rather than discovering data about the receiver, a more extensible solution uses the receiver identifier to resolve a service endpoint. The service at this endpoint can be standardized (this will be the SPSP entry-point), and in
future this service may be extended to provide additional functionality and data.

By decoupling the discovery of the service from the service itself we define distinct phases in the preparation of an ILP transfer: *discovery* and *setup*.
These phases can be defined by distinct entry and exit gates, and the specific implementations can be changed as long as the input and output of each phase is in a consistent format.

Using such an architecture, it is also possible to host the service at a URL that does not reveal any data about the receiver, allowing public discovery systems to be used without compromising the receiver's privacy.

Example of privacy protecting SPSP receiver URL:

- tel:+2612345678 - resolves to -> https://ist.ng/ea472-cd5346-87df2h6680 (using a public unsecured registry)
- SPSP session initiated at https://ist.ng/ea472-cd5346-87df2h6680 requires authentication

It is assumed that access to the SPSP receiver endpoints will be subject to policies that are designed to protect receiver
data privacy (that is, either not exposed on the public internet or protected behind an effective authorization system).

## Setup Phase

The setup phase is handled by SPSP. The protocol requires that some entity (which doesn't have to be the receiving DFSP) hosts a _receiver endpoint_ at which the sender can query an SPSP Server for the data required to setup a transfer. All that is required to
initiate setup using SPSP is the URL of the receiver endpoint.

## Discovery Phase

Working back from the requirements to start the setup phase, it follows that the discovery phase must simply return a URL.

### Normalization of Identifiers

Since the inputs to the discovery phase are only loosely typed as "an identifier" it may be useful to be specific and call this a URI.

Identifiers that do not have a natural URI form can usually be converted to one (or one can be defined for them).
Where an identifier is provided to a sending system that is not a URI it is the responsibility of the sending system to determine the correct form based on the context and, if required, through interaction with the user.

**Example 1**

* Sender provides the identifier `+26 78 097 8763`
* Sending system recognizes this as an E164 format number and converts it to the URI `tel:+26780978763`.

**Example 2**

* Sender provides the identifier `bob@dfsp1.com`
* Sending system prompts the user to specify if this is an email address or an account identifier and then converts the identifier to the form `mailto:bob@dfsp1.com` or `acct:bob@dfsp1.com`.

This normalization allows a more rigid definition of a discovery service such that any service that accepts URIs and returns URLs could be used to resolve SPSP receiver endpoint URLs from receiver identifiers.

### Discovery of SPSP Receiver Endpoint URL

Given all that has been defined to this point we can define a discovery service simply as a service that takes a URI representing a receiver identifier as input and returns a URL that should be the _receiver endpoint_ for an SPSP server providing services for that receiver.

Sending systems (DFSPs) _should_ determine which discovery service to use based on the URI scheme of the identifier.

The rules for this mapping (URI scheme/identifier type to discovery service) should be defined as part of each deployment.
Mojaloop should provide implementations of one or more discovery services to bootstrap ecosystems where no such thing exists, but it should be possible for a DFSP to be configured to use other discovery services as long as they meet the minimum requirement of
resolving a URL from a URI.

In deployments where all discovery is done through the same service (for example, a central directory) the logic for processing different identifier types can be deployed as part of that service.
Therefore it will be unnecessary for the sending system (DFSP) to be capable
of calling different services based on the identifier type.
While this is an optimization that may be possible for such a deployment, removing this logic from the DFSP will make introducing new discovery services in the future more difficult unless they are always proxied through the central service.

The logical steps for a sending DFSP are:

1. Get receiver identifier.
2. Normalize identifier to a URI if required.
3. Determine which discovery service to use based on URI scheme.
4. Resolve URI to URL using discovery service.
5. Initiate SPSP at resolved URL.

## Design Considerations

The Mojaloop project has some specific design constraints and assumptions which drive the design of this implementation. The project
favors the use of a central directory for discovery but also as a proxy for the quoting session with DFSPs. While this means it is not
necessary for the discovery and setup to be decoupled, maintaining this architecture future-proofs the solution for deployments where
these constraints and assumptions no longer hold.

### Central Directory

The central directory will host a simple lookup service that resolves a receiver identifier to an SPSP URL.
It should host different endpoints for each identifier type so that these can easily be changed in future if required and so the logic to differentiate between identifier types is built into the DFSPs from the start.

**Example**

 * tel:+26123456789 -send-lookup-query-to-> https://ist.ng/api/tel
 * acct:123456789@dfsp1.ng -send-lookup-query-to-> https://ist.ng/api/acct

The central directory lookup service will return a URL in the response for any identifier lookup. The URL is the one to use to initiate an SPSP session.

To optimize this process, in a deployment where the SPSP endpoints will be hosted by the IST, the URLs will use the same host (domain) as the lookup services. This will allow the client software at the sending DFSP to re-use the underlying connection for efficiency.

An HTTP session-based authorization model that is shared by both the lookup service and SPSP service will also mean that the client
is able to re-use its authorized HTTP session further optimizing this process.

Using HTTP/2 in this architecture should further optimize this process.

It is expected that the individual account details will not be held at the IST but that the IST will provide an SPSP proxy service to
the DFSPs blinded behind a non-descriptive SPSP endpoint URL.

**Example**

Step 1. Sender wishes to send money to +26 123 4567 (receiver identified by mobile number)

Step 2. Sending DFSP queries Central Directory for SPSP endpoint

```http
GET /api/lookup/tel?identifer=tel%3A%2B261234567 HTTP/1.1
Host: ist.ng
```

Step 3. Central directory resolves identifier (account at DFSP1) and returns a local URL that is a proxy to the SPSP Server at DFSP1.

```http
HTTP/1.1 200 Success
Content-Type: application/json
{
  "spspReceiver" : "https://ist.ng/api/spsp/2911ca95-7bab-4699-b23a-6c64c03f3475"
}
```

**Note:** The URL gives nothing away about which DFSP is being proxied.

Step 4. Sending DFSP initiates SPSP session at `https://ist.ng/api/spsp/2911ca95-7bab-4699-b23a-6c64c03f3475`

**Note:** Both the lookup API and the SPSP endpoint are hosted at the IST.
