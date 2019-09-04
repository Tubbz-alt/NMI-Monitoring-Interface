query
updateHostGroupRelations
	"Once fresh data are received about Groups and Hosts this methods build mixed structures."

	"For each MoniGroup populate the instance variable 'hostList' as a list of MonitHosts ".	
	self  groupList do: [ :gr |
	gr hosts: (OrderedCollection new).
	gr hostIdList do: [ :hoID |
		self hostList do: [ :host |
			(host id = hoID) ifTrue: [ gr hosts add: host ]. 
			]
		]
	].

	"For each MonitHost populate the instance variable 'groups' with MointGroups. "	
	self hostList do: [ :host |
	host groups: (OrderedCollection  new).
	self groupList do: [ :group |
		 (group hostIdList includes: (host id)) 
			ifTrue: [ host groups add: group  ].		
		]	
	].


