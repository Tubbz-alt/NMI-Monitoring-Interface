external command processing
waitForCommandOutputArray: aCommandString
	"Run a command in a shell process. Similar to the system(3) call in the standard C library.
	The active Smalltalk process waits for completion of the external command process."

	"OSProcess thisOSProcess waitForCommandOutputArray: 'echo Hello world!; ls /NOSUCHFILE'"

	| proc |
	(Smalltalk hasClassNamed: #PipeableOSProcess)
		ifTrue:
			[proc := (Smalltalk at: #PipeableOSProcess) command: aCommandString.
			^ Array
				with: (proc perform: #output)
				with: (proc perform: #errorUpToEnd)
				with: (proc perform: #processProxy) exitStatus]
		ifFalse:
			[self notify: 'the #waitForCommandOutputArray: method requires CommandShell'.
			^ Array with: '' with: '' with: nil]
