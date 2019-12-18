A MonitHost is class to represent a server, as it is represented in our MMonit server. 

A MonitHost contains an instance variable more respect to what is contained in the MMonit server, which is the 'groups' variable. This is a list which will contain one or more MonitGroup objects.


Instance Variables
	cpu:		<Object>
	events:		<Object>
	heartbeat:		<Object>
	hostname:		<Object>
	id:		<Object>
	led:		<Object>
	mem:		<Object>
	mmonit: <MMonit>
	status:		<Object>
	

cpu
	- xxxxx

events
	- xxxxx

heartbeat
	- xxxxx

hostname
	- xxxxx

id
	- xxxxx

led
	- xxxxx

mem
	- xxxxx
	
mmonit
  - reference to the MMonit object the is necessary to talk with the MMonit server. 	

status
	- xxxxx
