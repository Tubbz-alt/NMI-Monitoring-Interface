examples
printAllGroupsAndHosts
	"Print the list of all groups and their hosts as a Tree structure in Transcript window. 
	
	Example
	MMonit printAllGroups. 
	
	"
	
	[|mm| 
	mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
	Transcript cr. 
	Transcript show: '===== All Gropus and Hosts defined in MMonit ========'; cr. 
	mm groupList do: [ :group| 
		Transcript show: (group name); cr. 
		group hosts do: [ :host |
				Transcript show: '|_ _', (host hostname); cr. 
			].
		Transcript cr. 
		]	.
	Transcript show: '==============================='; cr ; cr. 
	] forkAt: Processor userBackgroundPriority . 
	
	 
	
