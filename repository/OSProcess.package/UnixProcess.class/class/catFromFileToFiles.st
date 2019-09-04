examples
catFromFileToFiles
	"Copy contents of a file to another file, with any error messages going 
	to a third file."

	"UnixProcess catFromFileToFiles"

	| in out err proc |
	in := OSProcess readOnlyFileNamed: '/etc/hosts'.
	out := OSProcess newFileNamed: '/tmp/deleteMe.out'.
	err := OSProcess newFileNamed: '/tmp/deleteMe.err'.
	proc := UnixProcess
				forkJob: '/bin/cat'
				arguments: nil
				environment: nil
				descriptors: (Array
						with: in
						with: out
						with: err).
	in close.
	out close.
	err close.
	proc ifNil: [self noAccessorAvailable].
	^ proc