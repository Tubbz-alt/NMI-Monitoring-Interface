authentication
unAuthenticate
	|cmd out status outString|
   cmd := 'curl -b {1}/.monit/cookie \
        http://{2}:{3}/status/login/logout' format: 
  {self homePath. self mmonitHost. self mmonitPort.  } .
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	(status = 0) ifFalse: [ self halt: 'Could not complete the authentication. ' ]
	
