private
numberOfOpenFiles
	"Answer the number of files currently open for this OS process. This works
	only on a system with a /proc filesystem and file descriptors located in a
	directory called /proc/<pid>/fd. On other systems, just answer 0."

	"UnixProcessTestCase new numberOfOpenFiles"

	| path |
	path := '/proc/' , OSProcess thisOSProcess pid printString, '/fd'.
	(OSProcess directoryExists: path) ifFalse: [ ^ 0].
	^ OSProcess useFileMan
		ifTrue: [((Smalltalk at: #DirectoryEntry) pathName: path) children size]
		ifFalse: [OSProcess useFileSystem
			ifTrue: [ (path perform: #asFileReference) children size ]
			ifFalse: [ ((Smalltalk at: #FileDirectory) on: path) entries size ]]
