I am Timer object. I require an amount of time to wait and a block of code to execute. 

If creted and activated, after each fixed amount I run the code block.

--------- Example --------------------------------------
"Keep the Transcript window open to see something."
t1 := Timer firingEach: 1000  action: [ 
	Transcript show: ('{1} - hello' format: {(1 to: 100) atRandom.})   ; cr 
	].  
t1 start.
t1 stop. 
t1 process terminate.

---------------------------------------------------------------




Instance Variables
	action:		<Object>
	isRunning:		<Object>
	process:		<Object>
	timeSlot:		<Object>

action
	- xxxxx

isRunning
	- xxxxx

process
	- xxxxx

timeSlot
	- xxxxx
