authentication
authenticateUser: userString file: aFilename 
	"Autentication is made trough user and password, username 
	 is 'userString' and password is taken from a local file 'aFilename'  "
	|cmd out status outString passString diz|
	diz := self getUserPasswordDictionary: aFilename.
	passString := diz at: userString.
	passString ifNil: [self halt: ('There was no password for user: ', userString) ].
	cmd := 'curl -b {5}/.monit/cookie \
    	-d z_username={1} \
    	-d z_password={2}  \
    	-d z_csrf_protection=off \
   http://{3}:{4}/z_security_check' format: 
		{userString. passString.
			self mmonitHost. self mmonitPort. self homePath }. 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	(status = 0) ifFalse: [ self error: 'Could not complete the authentication. ' ]