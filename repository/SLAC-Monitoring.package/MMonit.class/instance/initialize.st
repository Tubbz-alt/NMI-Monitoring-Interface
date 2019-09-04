initialize-release
initialize
	host := 'localhost'.
	port := '18020'.
	user := nil.
	password := nil.
	cookiePath := '~/.monit/cookie'.
	webServer := nil.
	"timer" 
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
