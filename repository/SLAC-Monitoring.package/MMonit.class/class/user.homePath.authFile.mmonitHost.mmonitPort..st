instance creation
user: userString homePath: homeString authFile: fileString mmonitHost: mmonitHostString
			 mmonitPort: mmonitPortString
	" -] Create a MMonit object   
	   -] Log into MMonit and take all data necessary 
      -] Logout.
      -] return with the newly created MMonit object. 

	Example. 
	mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
   mm explore. 
	"
	|mm|
	mm := self new. 
	mm mmonitHost: mmonitHostString withBlanksTrimmed.
	mm mmonitPort: mmonitPortString withBlanksTrimmed. 
	mm homePath: homeString withBlanksTrimmed.
	mm setTheCookie . 
	mm authenticateUser: userString file: fileString. 
	mm updateGroupsList.
	mm updateHostsList .
	mm updateHostGroupRelations .
	mm unAuthenticate .
	
	^ mm 
	
	
	
	
	 
	
