query
isRedLedGroup
	"
	A group is said to be a RedLedGroup if at least one of the host in the group has 
	stats led set to RED in Monit interface. 
	
	Returns boolean.
	"
	self hosts do: [ :host | 
		(host ledColor = (Color red)) ifTrue: [ ^ true  ]
	].
	^ false
	
