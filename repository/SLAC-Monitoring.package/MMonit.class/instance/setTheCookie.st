authentication
setTheCookie
	|cmd out status|
	cmd := 'curl -c {1}/.monit/cookie  http://{2}:{3}/index.csp' format: 
		{self homePath. 
			self mmonitHost.
			self mmonitPort }. 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	(status = 0) ifFalse: [ self error: 'Can''t set the cookie.'  ].
		
