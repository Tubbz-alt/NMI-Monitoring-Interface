examples
printOnlyRedLedGroups
	"All groups where at least one host has a redLed (monit status interface) are said to be RedLedGropus.
	
	 Here we prinnt al groups that can be considered red, along with their RED hosts. 
	
	"
	
	[
	|mm outStr| 
	mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
	Transcript cr. 
	Transcript show: '===== All RedLed Groups/Hosts in MMonit ========'; cr. 
	mm groupList do: [ :group| 
		"we want to print the host elements only if at least one is of color RED".
		(group isRedLedGroup) ifTrue: [	
				outStr := '%-20s %-10s %-10s %-10s' printf: {group name. 'cpu'. 'mem'. 'ledColor'  }.
			   Transcript show: outStr; cr. 
			   group hosts do: [ :host |
					"print the host only if it is of color RED"
					host isRedLedHost ifTrue: [
				   outStr := '|__%-20s %-10s %-10s %-10s ' printf: {
					host hostname. host cpu asString. host mem asString. 
					host ledColor printString. }.
				   Transcript show: outStr; cr.
				   ]
		      ].
		    Transcript cr. 				
		]].
	Transcript show: '==============================='; cr ; cr. 
	] forkAt: Processor userBackgroundPriority . 
	
	 
	
