query
getHostDetails: aHost
	"Given aHost object retrives the list of details."

	|cmd out status outString jOut|
	cmd := 'curl -b {1}/.monit/cookie \
 		  http://{2}:{3}/status/hosts/get?id={4}' format: 
		{  self homePath. self mmonitHost. self mmonitPort. aHost id}. 
		 
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	"Halt if we could not get the host list."
	(status = 0) ifFalse: [ self error:  
		('Could not get the details for host: {1}, id:{2}. ' format: {aHost name. aHost id}) 
		] . 
	
	"Parse the string and make a JSON object"
	jOut := Json readFrom: outString utf8ToSqueak readStream.
	
	^ jOut 
	
	