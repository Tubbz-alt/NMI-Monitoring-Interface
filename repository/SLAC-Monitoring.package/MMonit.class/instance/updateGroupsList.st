query
updateGroupsList 
	"Get the list of groups managed in MMonit. Store it into the instance variable. "
	|cmd out status outString jOut tmp groupListTmp|

	cmd := 'curl -b ~/.monit/cookie \
		   http://localhost:18020/admin/groups/list'.
	out := PipeableOSProcess waitForCommand: cmd. 
	status := out processProxy exitStatus.
	outString := out output. 
	"Halt if we could not get the host list."
	(status = 0) ifFalse: [ self halt: 'Could not get the list of hosts. ' ] . 
	"Parse the string and make a JSON object"
	jOut := Json readFrom: outString utf8ToSqueak readStream.
	
"	(jOut at: 'groups') at: 1.  a JsonObject('hosts'->#(1205 73515 73602 73684) 'id'->636304 'name'->'psdm-infra' )"
	
	groupListTmp := OrderedCollection new. 
	(jOut at: 'groups')  do: [ :gr | 
			tmp := MonitGroup  new.
			tmp name: ( gr at: 'name' ).
			tmp id: (gr at: 'id').
			tmp hostIdList: (gr at: 'hosts').		
			groupListTmp add: tmp. 
		]. 
	
	"set the instance variable"
	groupList := groupListTmp. 

	