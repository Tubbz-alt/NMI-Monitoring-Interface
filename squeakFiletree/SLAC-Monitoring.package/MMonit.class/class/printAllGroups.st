examples
printAllGroups
	"Print the list of all groups in Transcript window. 
	
	Example
	MMonit printAllGroups. 
	
	"
	|mm|
	mm := MMonit new. 
	mm setTheCookie . 
	mm authenticateUser: 'API' file: '/home/p/.monit/auth'. 
	mm updateGroupsList.
	mm updateHostsList .
	mm updateHostGroupRelations .
	mm unAuthenticate .
	
	Transcript cr. 
	Transcript show: '===== All Gropus defined in MMonit ========'; cr. 
	mm groupList do: [ :group| 
		Transcript show: (group name); cr. 
		]	.
	Transcript show: '==============================='; cr ; cr. 
	
	
	 
	
