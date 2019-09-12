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
	"Mutually exclusive semaphore to access the data structures"
	cacheMutex := Semaphore forMutualExclusion.
	"timer to update the data coming from MMOnit." 
	timer := 
		Timer firingEach: (1e3)*60  action: [ 			
		 [ 
			self updateDataFromMMonit . 
			Transcript show: ('{1} -- MMonitUpdateData' format: {Date dateAndTimeNow. }); cr.
		 ] on: Error do: [ :e| 
			Transcript show: ('{1} -- Catched error in MMonit Update: {2}' 
									format: {Date dateAndTimeNow. e}); cr.			
		 ].
		].  
