A MMonit is class to query machines status to a MasterMonit server. 

. The examples are designe to run in LCLS psmetric01 MMonit. 

. Some examples write in Transcript. So take a look there. 

test asdf .

---------- EXAMPLES --------------------

----- Start the service. Output stuff is in Transcript -------------------------

"Simplified command for use in Nicola FBS machine"
"mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'. "

"if necessary set a Proxy, as in this example. "
HTTPSocket useProxyServerNamed: 'psproxy' port: 3128.

"Remember to access git via HTTPS in from psmetric01, so to use the proxy."

mm := MMonit user: 'API'  
	homePath: '/reg/neh/home/nmingott'
	authFile: '/reg/neh/home/nmingott/.monit/auth'
	mmonitHost: 'localhost'
	mmonitPort: '8020'.

mm destroyWebServer .
mm createWebServer .
mm defineServices .

"auto-update data from MMonit every 60 sec. "
mm startLoopUpdateMMonit .

"Informative logging data are printed into Transcript window" 
Transcript open.

"stop autoupdating data from MMonit. "
mm stopLoopUpdateMMonit. 

-------------------------------------------------------------------------------------------

--- Just to see something interactively
MMonit printAllGroups .    
... 
MMonit printAllGroupsAndHostsWithDetails .   
printRedLedHosts
printRedLedGroups

--- Instantiating objects: 
mm := MMonit user: 'API' authFile: '/home/p/.monit/auth'.
mm groupList. 

----------------------------------------------

TODO.
-] message to update 'mm' obejct data 
-] 


This class requires:
. To be run on a Unix like system 
. OSProcesses
. The program "curl" to access MMonit web server. 


Instance Variables
	cookiePath:		<Object>
	host:		<Object>
	password:		<Object>
	port:		<Object>
	user:		<Object>

cookiePath
	- xxxxx

host
	- xxxxx

password
	- xxxxx

port
	- xxxxx

user
	- xxxxx
