query
updateHostsList
	"get the list of hosts in MMonit. Store the value into the instance variable. "

	|cmd out status outString jOut tmp hostListTmp|
	cmd := 'curl -b ~/.monit/cookie \
 		  http://localhost:18020/status/hosts/list'.  
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	"Halt if we could not get the host list."
	(status = 0) ifFalse: [ self error: 'Could not get the list of hosts. ' ] . 
	"Parse the string and make a JSON object"
	jOut := Json readFrom: outString utf8ToSqueak readStream.
	"^ jOut"
	"build hostList "
	hostListTmp := OrderedCollection new.
	(jOut at: 'records') do: [ :el | 
			tmp := MonitHost new.
			tmp cpu: (el at: 'cpu').
			tmp events: (el at: 'events').
			tmp heartbeat: (el at: 'heartbeat').
			tmp hostname: (el at: 'hostname').
			tmp id: (el at: 'id').
			tmp led: (el at: 'led').
			tmp mem: (el at: 'mem').
			tmp status: (el at:'status').
			tmp statusId: (el at:'statusid').
						
			hostListTmp add: tmp.
		].
	
	"set instance variable."
	hostList := hostListTmp. 
	
	