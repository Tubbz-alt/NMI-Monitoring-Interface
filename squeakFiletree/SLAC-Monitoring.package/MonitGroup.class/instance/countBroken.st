printing
countBroken
	"Get a summary of :
	-] the number of hosts that are down.
   -] the number of services that are not working, counted respect all hosts that are NOT down.
  => Returns a dictionary with keys #hostsDown , #servicesDown. 
	"
	|out hostD serviceD re|
	out := Dictionary new.
	"hostDown and serviceDown count variables."
	hostD := 0.
	serviceD := 0. 
	re := '(\d+) out of (\d+) services are available' asRegex.
	self hosts do: [ :host | 
		(host status prefixMatchesRegexIgnoringCase: 'No report from monit') 
			ifTrue: [ hostD := (hostD + 1 )] .  
		(re search: host status) 
			ifTrue: [
				|onCount availableCount offCount|
				onCount := ((re subexpression: 2) asInteger).
				availableCount := ((re subexpression: 3) asInteger).  
				offCount := (availableCount - onCount). 
				serviceD := (serviceD + offCount ) .
				] .	
		].
	out add: #hostsDown -> hostD. 
	out add: #servicesDown -> serviceD. 
	 
	^ out 	
