# Transferring funds between different Mojaloop implementations

## Revision history
| Version | Date | Reason | Author |
|---------|------|--------|--------|
| 0.1 | 23 April 2018 | Initial Draft | Michael Richards  |

## References
The following references are used in this document

| Document | Version | Date |
|------|--------|--------|
| Open API for FSP Interoperability Specification | 0.95 | 8 January 2018 |

## Glossary 
The following abbreviations are used in this document.

| Abbreviation | Text | Reference |
|------|--------|--------|
| ALS | Account Lookup System | |
| CIP | Cross-implementation Provider | |
| DFSP | Digital Financial Service Provider | |
| DMZ | DeMilitarised Zone: the area of a service which supports public access via internet connections. | |
| ILP | Interledger Protocol | https://interledger.org/rfcs/0027-interledger-protocol-4/ |
| Implementation | A group of ledgers implementing the ILP protocol which are visible to each other over a single VPN | |
| MSISDN | Mobile Station International Subscriber Directory Number: a subscription to a mobile network | |
| Oracle | A specialist service providing directory services for identifiers of a particular type | |
| VPN | Virtual Private Network | |

## Introduction 
This document describes an outline design to support transfers of funds between parties who are customers of DFSPs which belong to different Mojaloop implementations. It represents the content of a discussion which took place as part of the Mojaloop PI-2 planning sessions held in Johannesburg, South Africa on April 5th, 2018.

The discussion originally included multi-currency issues as well as cross-border issues. However, the group decided that it was prudent to treat multi-currency questions separately, and this document therefore discusses multi-currency issues only where they impact directly on cross-border issues. In addition, the group noted that the same issues would arise where more than one Mojaloop solution was implemented in a single country; and the solution is therefore characterised in the rest of this document as a cross-implementation solution.

The document takes the form of a journey through the stages of a transaction, identifying the additional requirements for a cross-implementation solution at each stage of the process. At each point, reference is made to the corresponding sections of the Open API specification where this is feasible (see 1 above.)

## Schematic of a cross-implementation solution

The following schematic shows the proposed structure of a cross-implementation payments system. In this system, Alice subscribes to a DFSP which is on the same VPN as Mojaloop implementation 1. She wants to make a payment to Bob, who subscribes to a DFSP on a different implementation (implementation 2.) The Mojaloop protocol means that, in the normal run of things, it would not be possible to transfer money between these systems. This proposal discusses how this could be done.

[TODO]

Figure 1: schematic of a cross-implementation solution

## Cross-implementation providers

The proposal makes use of a new type of entity: the cross-implementation provider (CIP). The CIP implements a bridge between two implementations of Mojaloop, as can be seen in the schematic in Figure 1. A cross-implementation provider is a member of more than one Mojaloop implementation. In the schematic above, the CIPs are both members of two Mojaloop implementations (Implementation 1 and Implementation 2,) but there is no restriction on the number of Mojaloop implementations of which a CIP can be a member. A CIP will have a settlement account in each of the Mojaloop implementations it supports, and will therefore be able to transfer funds between the two systems.

The sequence of steps for transferring funds between Alice (who belongs to DFSP 1A in implementation 1) and Bob (who belongs to  DFSP 2A in implementation 2) via CIP 1 is as follows. Note that this sequence disregards charges for the sake of simplicity.

 1. Alice’s account is decremented in DFSP 1A
 1. DFSP 1A’s settlement account is decremented
 1. CIP 1’s settlement account in implementation 1 is incremented.
 1. CIP 1’s settlement account in implementation 2 is decremented.
 1. DFSP 2A’s settlement account is incremented.
 1. Bob’s account is incremented in DFSP 2A.

It can therefore be seen that this arrangement leaves the settlement accounts in both implementations consistent, allowing the CIP to make its own arrangements in relation to its settlement accounts in each implementation.

## Identifying the destination party

The first stage in the transfer of funds is the identification of the counterparty in the transaction: that is, the party who is to be credited. This stage is described in Section 5.2 of the Open API specification (see 1 above.)

In order for a cross-implementation solution to work, the directories used by the ALS will need to be modified to include information about counterparties who are represented by DFSPs in implementations other than the one who represents the originating party. These modifications divide into two different categories, as described below

### Globally unique identifiers

There are some ways of identifying a counterparty which are reliably globally unique: for instance, an MSISDN. In these cases, it is sufficient for the originating party’s DFSP to request information from the ALS in the form used at present. The expectation is that the oracle for MSISDNs and, by extension, oracles for other globally unique identifiers, will contain information for all subscribers who are associated with a DFSP which identifies the DFSP to which they belong. If a subscriber does not belong to a DFSP, then the search will return nothing. If, on the other hand, a subscriber does belong to a DFSP, then the ALS will return the URL of the DFSP to which the subscriber belongs, as at present. This form of search does not require any modifications to the existing interface, although the consequences for the requesting DFSP of the information returned will be different. These differences are described in Section 6 below.

### Non-unique identifiers

Other ways of identifying a counterparty are not reliably unique across all possible implementations. An example is a national ID number, which might be duplicated in another country’s ID system. In this case, additional information must be supplied to disambiguate the ID number: to say, for instance, that this is a national ID belonging to the Kenyan or the Peruvian national ID scheme.

Disambiguation will require the inclusion of an additional piece of information to the submission to the ALS. One such additional piece of information which already exists is the Party Sub ID or Type (defined in Section 6.3.27 of 1 above.) However, the addressing examples given in Section 4.2 of 1 above suggest that this will not be sufficient. In one of the examples given there, an employee of a business is identified by giving the employee’s name as a Sub ID, while the business name is given as the main identifier. Since a business name will not be globally unique, the Sub ID will not be available to define the context in which the non-unique identifier is to be evaluated. It will therefore be necessary to use an addition identifier (for instance, “IdentifierContext”) to specify the context in which a non-unique identifier is to be evaluated.

In the case of globally unique identifiers, a single instance of an oracle is assumed to be capable of including information about all members of that information type who are represented by a DFSP. Maintenance of the list therefore devolves on a central authority, and no individual implementation need assume responsibility for it. With non-unique identifiers, however this is not the case. The model for the maintenance of directories described in 1 above suggests that each DFSP will be responsible for updating its local ALS (if there is one) using the /participants URI (see Section 5.2.) this is the only model that really makes sense, as it is hard to see how a properly segmented global directory of (for instance) business names could be created and maintained.

Two possibilities suggest themselves. These are outlined in more detail below as a stimulus to further discussion.

#### Registration 

In order to implement a cross-border model, each Mojaloop system will be registered with all other Mojaloop systems with which it will support interactions. This is required to support the provision of retail quotations for transfers (see Section 6 below.) As part of the registration process, a Mojaloop instance could register a callback to enable it to receive directory updates for non-unique identifiers from the Mojaloop instance with which it was registering, and could register a callback from the Mojaloop service with which it was registering to enable it to update that service with new directory input as it became available. This would enable it to receive ALS updates from all the participating Mojaloop instances with which it was connected as they were made, and to broadcast changes to its own directory to all interested parties. This would require changes to be made to the operation of the ALS, but would not require further API changes.

#### Consolidation 

As described above, each globally unique identifier will have an oracle service which will provide a global view of identifiers and the DFSP to which each belongs. An alternative to the distributed system of directories for non-unique identifiers described above would be to maintain a consolidated service to be accessed via an oracle, which would be updated by each subscribing ALS as it received updates from the DFSPs which used it. This would mean that a global oracle would gradually be built up, with the advantages over the registration system described in Section 5.2.1 above that an update to the oracle would only need to be made once; they would then be available to any ALS whatsoever. This mechanism could also be used, of course, to keep oracles of unique identifiers up to date as well.

The detailed design for implementing the selected maintenance method(s) is left to a later stage of this document.

## Obtaining a retail quote

Once a subscriber has been identified, the next stage in the process of transferring funds is the generation of a retail quote. This is a statement from the target DFSP of the charges it proposes to levy to execute the transaction requested by the originator. It is described in Section 5.5 of 1 above. This section discusses the process of obtaining a retail quote where the destination DFSP is on a different Implementation from the originating DFSP.

When an oracle returns information to the ALS that it has identified a counterparty, it does so in the form of the URL of the DFSP to which the counterparty subscribes. Since all Mojaloop implementations use VPNs to secure communications between their participants, they will only be able directly to see DFSPs which belong to the same VPN. The ability to reach the URL returned by an oracle is therefore a reliable indicator that the DFSP belongs to the same Mojaloop implementation as the originator.

If the URL is not visible on the VPN, then it is a reliable sign that the counterparty belongs to a different Mojaloop implementation from the originator. In this case, the originating Mojaloop implementation needs to find a route to the destination Mojaloop implementation. This will be done in the following way.

Each Implementation will register a URL which it can use to communicate with the DMZ of each of the other Implementations with which it supports interoperation. When a DFSP requests a quote from a payee’s DFSP, the ILP switch will check whether the payee’s DFSP is visible to it or not. If it is not visible (i.e. if the payee DFSP belongs to another ILP,) then the payer DFSP’s ILP will ask each of the other ILPs with which it supports interoperation whether the payee DFSP is known to them or not. If any of the queried ILPs recognises that the payee DFSP, then it will respond positively.

The payer ILP will then request a retail quote from those ILP switches which responded positively. The payee DFSP will create the quote and seal it in the normal way, and will return it to its own ILP switch. The payee ILP switch will return the sealed quote to the payer ILP switch, which will then return it to the payer DFSP in the normal way. No changes will be required to the existing interface.
The description above rests on the following assumptions:
 1. According to this description, a DFSP can belong to more than one ILP. This would be the case if a DFSP could also act as a CIP.
 1. We assume that a DFSP can only belong to more than one ILP if it also acts as a CIP.
 1. The existing interface assumes that only one quote will be returned for each request. This assumption is valid as long as all DFSPs in fact belong to one and only one ILP.

### Authorizations 

The considerations detailed in this section will also need to apply to the /authorizations resource (see Section 5.6 of 1 above.) If an authorisation is required from a payee, the payee DFSP will need to be contacted in the same way as for the provision of a quote.

## Obtaining a wholesale quote

When a retail quote has been obtained from the payee DFSP, it will be augmented with a wholesales quote. A wholesale quote adds charges which are paid by the payer DFSP to cover the transport of the transaction to the payee DFSP. In order to calculate these charges, it is necessary to work out available routes between the payer and payee DFSPs, rather than going directly to the payee DFSP, as was the case with the retail quote. This section covers the way in which a payer DFSP will obtain wholesale quotes.

The process of obtaining a wholesale quote also raises the question of regulatory compliance. For the sake of simplicity, this is dealt with separately in Section 0 below.

Once a record has been returned to the originating DFSP confirming that the requested identifier has been matched to a DFSP somewhere in the world, a further question remains to be answered: is it possible to map a route by which the requested transfer can reach the destination? This section addresses the means by which this question is answered.

To recap: when an oracle returns information to the ALS that it has identified a counterparty, it does so in the form of the URL of the DFSP to which the counterparty subscribes. Since all Mojaloop implementations use VPNs to secure communications between their participants, they will only be able directly to see DFSPs which belong to the same VPN. The ability to reach the URL returned by an oracle is therefore a reliable indicator that the DFSP belongs to the same Mojaloop implementation as the originator.

If the URL is not visible on the VPN, then it is a reliable sign that the counterparty belongs to a different Mojaloop implementation from the originator. In this case, the originating Mojaloop implementation needs to find a route to the destination Mojaloop implementation.

The following diagram shows an example which is used to illustrate this discussion:

[TODO]

In this illustration, Alice is still intending to send money to Bob, but her route is of necessity slightly more complicated. Alice’s DFSP is attached to Implementation 1, while Bob’s DFSP is attached to Implementation 4.

This question resolves itself into a known mathematical problem (find all the possible routes between two nodes on a graph.) The implementation will need to be mapped onto an architecture where, as here, the nodes act independently of each other rather than being passive components in a problem which is solved panoptically; but in principle the solution is known. The detail of its implementation is left for later definition. It should be borne in mind, however, that the solution may become relatively complicated even in a small-scale example such as the one given in the diagram above.

Two further questions need to be dealt with as part of this discovery. These are dealt with below.

### Charges

A CIP may make a charge for processing a transaction. If it does, then it will need to include that charge in its response; and implementation switches will need to include the charges in the route lists that they eventually return to the payer DFSP. IT will be the responsibility of the payer DFSP to decide on a route, and that decision may include a calculation of lowest total cost; but it will be the responsibility of the DFSP to make that calculation.

At present, transactions which are being executed do not contain a statement of the currency in which they are currently denominated. It is assumed that a recipient will know which currency a transaction is denominated in. However, it may well be that in this world a CIP may make its charges in a currency which is not used by either of the parties to a transaction. Imagine, for instance, that a US-based organisation decides to make itself a world hub for inter-implementation transactions, such that any payer DFSP can reliably find a payee DFSP in one hop by routing the transaction through the hub. If the world hub CIP levies its charge in USD, how will that charge in fact be levied? When the transaction arrives at the hub, one would expect that the charge will need to be levied in a known currency and at an exchange rate fixed at the time of quotation.

### Regulatory compliance

When a CIP handles a transaction between two parties, it may make itself liable to demonstrate that it has taken proper steps to assure itself that the transaction complies with the regulations in force in the jurisdiction where the CIP is implemented. These regulations may differ widely between jurisdictions, and any solution to this problem should therefore be decentralised to the providers themselves, rather than rely on a central authority. The problem may not need to be solved solely for CIPs, since it will also apply to other participants in the execution of a transaction, such as providers of FX services; however, the term CIP is used for simplicity in the rest of this discussion. The proposal for meeting this requirement is as follows.

As a wholesale quote is being prepared, a CIP should be able to add to its response, as well as the charge described in Section 7.1 above, a statement of the information required from the parties to the transaction to meet the requirements of the provider’s regulatory regime. This statement of regulatory requirements should contain a variable number of categories for which information is requested.

*Assumption:* at some point we will need an overall definition of terms, such that participants will be able to understand each other’s requests and map them onto their information. This definition will be extensible, so that new requirements from new or existing regulators can be included.

If the CIP is asking for information about the payee, then the payee DFSP will parse the information requests and fill in those for which it has information. For any items which are requested for which the payee DFSP does not have information available, the payee DFSP will make a standard response stating this.

If the CIP is asking for information about the payer, then the requests will be returned along with the route and charge information. It will be the responsibility of the payer DFSP to parse the information requests for the selected route and to fill in those for which it has the requested information. At this point, matching regulatory requests with the information available to a DFSP may become an important part of selecting a route. In any case, the information will be encrypted using a key provided by the CIP in question, and will be included in the information accompanying the transaction when it is executed. It will be the responsibility of each CIP through which the transaction passes to decrypt the information using its private key, check it for completeness and either forward the transaction or reject it depending on the result of the check.

## Executing a transaction

When the payer DFSP has selected a route, it will execute the transaction. This process is described in Section 5.7 of 1 above.

The execution process will be the same as at present, with the following exceptions:

 1. The initiator of the transaction will need to be able to send a list of intermediates (CIPs on the selected route) as well as the destination address. At present (Table 22 in section 5.7.2.1 of 1 above) it appears that only a single destination Is supported.
 1. The initiator will send an amount which is equal to the amount specified by the payee DFSP as part of the quotation process plus any charges levied by intermediates on the specified route
 1. When an intermediate receives a transaction for forwarding, it will perform the following actions:
    1. Remove the amount of the charge it has agreed to levy from the transaction amount.
    1. Decrypt the compliance information, if there is any. Persist the compliance information.
    1. Check the compliance information for correctness. If the information is incorrect or insufficient, cancel the transaction and return the cancellation to the forwarder.
    1. Reserve funds to cover the charge, debiting the forwarder’s settlement account in the implementation and crediting its own settlement account in the implementation.
    1. Reserve funds to cover the remainder of the amount, debiting the forwarder’s settlement account in the implementation and crediting its own settlement account in the implementation.
    1. Forward the transaction to the next intermediate.
 1. When the eventual destination DFSP has confirmed or declined the transaction, the confirm or decline message will be passed back down the chain of intermediaries.
 1. When an intermediate receives a confirmation message, it will confirm the funds reservations in its ledgers for the charge and the residual amount, and will return to the provider before it in the chain.
 1. When an intermediate receives a cancellation message, it will cancel the funds reservations in its ledgers for the charge and the residual amount, and will return to the provider before it in the chain.

This concludes the changes required to support intermediate processing and charging for inter-implementation transfers. 