# Directory service API

The directory service is used for lookup services: For example, finding URLs, obtaining lists of districts, towns, participants, and so on.

1. **directory.item.fetch** - returns item lists for things like currencies, countries, districts, towns, etc.
1. **directory.participant.fetch** - returns list of DFSPs, merchants, NGOs and other types of participants
1. **directory.name.get** - looks up name of end user, given the end user number
	* parameters
	    * userNumber | accountNumber - recipient user or account Number
  	* result
	    * userURL | accountURL - recipient full user or account URLs, including the end point DFSP
	    * currency - recipient account currency	    
	* errors
    	* directory.userNotFound - recipient not found
    	* directory.accountNotFound - recipient account not found
