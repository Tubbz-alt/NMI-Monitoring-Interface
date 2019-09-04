authentication
showCookie
	"Return the string contained in the cookie file."
	|cmd out cmdResults file string|
	"This part was used to get the HOME directory. not sure if to use it again."
	cmd := 'cd ~; pwd'. 
	out := PipeableOSProcess waitForCommand: cmd. 
	out processProxy exitStatus.
	cmdResults := (out output) withBlanksTrimmed. 
   "	file := FileStream fileNamed: ('{1}/.monit/cookie' format: {cmdResults.} ). "
	file := FileStream fileNamed: ('/home/p/.monit/cookie' format: {cmdResults.} ).
	string := file contentsOfEntireFile. 
	file close.
   ^ string
