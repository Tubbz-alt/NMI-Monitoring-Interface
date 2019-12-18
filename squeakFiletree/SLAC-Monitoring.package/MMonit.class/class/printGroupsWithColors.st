examples
printGroupsWithColors
	|mm| 	
	mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
	Transcript cr. 
	Transcript show: '===== All Gropus and their color  ========'; cr. 
	mm groupList do: [ :group | 
		Transcript show: (group printString, ' --- ', group ledColor printString ) ; cr.
	]

