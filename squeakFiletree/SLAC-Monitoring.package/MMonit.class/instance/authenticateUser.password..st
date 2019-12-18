authentication
authenticateUser: userString password: passString  
	|cmd out status outString|
	cmd := 'curl -b ~/.monit/cookie \
    	-d z_username={1} \
    	-d z_password={2}  \
    	-d z_csrf_protection=off \
   http://localhost:18020/z_security_check' format: {userString. passString}. 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	(status = 0) ifFalse: [ self error: 'Could not complete the authentication. ' ]