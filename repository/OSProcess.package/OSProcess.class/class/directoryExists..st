compatibility
directoryExists: path
	"Answer true if a directory of the given name exists. The given name may
	be either a full path name or a local directory within this directory."

	^ self useFileMan
		ifTrue: [((Smalltalk at: #DirectoryEntry) pathName: path) exists]
		ifFalse: [self useFileSystem
			ifTrue: [ (path perform: #asFileReference) exists ]
			ifFalse: [ (Smalltalk at: #FileDirectory) default directoryExists: path ]]
