examples
printAllGroupsAndHostsWithDetails
	"Print the list of all groups and their hosts as a Tree structure in Transcript window.
	 
	 The detail of CPU usage and memory usage are displayed. 
	
	Only drawback here is that i would like the output to be sent font DejaVuSansMono. 
	to have the table well aligned. 
	
	Example
	MMonit printAllGroupsAndHostsWithDetails . 
	
	"
	
	[
	|mm outStr| 
	mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
	Transcript cr. 
	Transcript show: '===== All Gropus and Hosts defined in MMonit with details ========'; cr. 
	mm groupList do: [ :group| 
		outStr := '%-20s %-10s %-10s %-10s' printf: {group name. 'cpu'. 'mem'. 'ledColor'  }.
		Transcript show: outStr; cr. 
		group hosts do: [ :host |
			 outStr := '|__%-20s %-10s %-10s %-10s ' printf: {
				host hostname. host cpu asString. host mem asString. 
				host ledColor printString. }.
	        "	Transcript show: '|_ _', (host hostname); cr. "
				Transcript show: outStr; cr. 
			].
		Transcript cr. 
		]	.
	Transcript show: '==============================='; cr ; cr. 
	] forkAt: Processor userBackgroundPriority . 
	
	 
	
