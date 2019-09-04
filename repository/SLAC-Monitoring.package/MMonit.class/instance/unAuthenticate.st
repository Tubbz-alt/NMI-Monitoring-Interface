authentication
unAuthenticate
	|cmd out status outString|
   cmd := 'curl -b ~/.monit/cookie \
        http://localhost:18020/status/login/logout'. 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	(status = 0) ifFalse: [ self halt: 'Could not complete the authentication. ' ]
	
