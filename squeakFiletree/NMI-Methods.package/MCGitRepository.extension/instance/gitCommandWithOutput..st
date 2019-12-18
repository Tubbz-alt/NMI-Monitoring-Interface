*NMI-Methods
gitCommandWithOutput: aString

	"The output is returned. It is up to the programmer to manage output and exit code."
	| proc cmdLine |
	cmdLine := self class gitPath, (' --git-dir="{1}{3}.git" --work-tree="{1}" {2}'
		format: {directory pathName. aString. FileDirectory slash}).
	
  Transcript showln: '[Metacello-Git] Running "', cmdLine, '"...'.
		
	proc := 	PipeableOSProcess waitForCommand: ( cmdLine ) .	
		
	^proc 
		
