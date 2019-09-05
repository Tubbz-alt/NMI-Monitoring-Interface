authentication
setTheCookie
	|cmd out status|
	cmd := 'curl -c ~/.monit/cookie  http://localhost:18020/index.csp'. 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	(status = 0) ifFalse: [ self error: 'Can''t set the cookie.'  ].
		
