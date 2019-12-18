initialize-release
initialize
	"coordinates of the local web server to whom Grafana connects"
	"host := #(172 21 32 98)."
	host := '172.21.32.98'.
	port := '3001'.
	"coordinates of the MMonit server" 
	mmonitHost := 'nil'.
	mmonitPort := 'nil'.
	"user credentials to access to MMonit"
	user := nil.
	password := nil.
	homePath := '/home/p'. 
	cookiePath := '~/.monit/cookie'.
	webServer := nil.
	"Keep a limit of system down history of max 10,000 entries."
   systemDownHistory := SystemDownHistory newWithCapacity: 1e4.
	"Mutually exclusive semaphore to access the data structures"
	cacheMutex := Semaphore forMutualExclusion.
	"timer to update the data coming from MMOnit." 
	timer := 
		Timer firingEach: (1e3)*60  action: [ 			
		 [ 
			"update the raw data coming from MMonit"
			self updateDataFromMMonit . 
			"update the list history of services/hosts down"
			systemDownHistory addIfNew: (SystemDownStatus newWithMMonit: self).
			Transcript ensureCr; show: ('{1} -- MMonitUpdateData' format: {Date dateAndTimeNow. }); cr.
		 ] on: Error do: [ :e| 
			Transcript ensureCr; show: ('{1} -- Catched error in MMonit Update: {2}' 
									format: {Date dateAndTimeNow. e}); cr.			
		 ].
		].  
