compatibility
fileExists: path
	"Answer true if a file of the given name exists. The given name may be
	either a full path name or a local file within this directory."

	^ self useFileMan
		ifTrue: [((Smalltalk at: #FileEntry) pathName: path) exists]
		ifFalse: [self useFileSystem
			ifTrue: [ (path perform: #asFileReference) exists ]
			ifFalse: [ (Smalltalk at: #FileDirectory) default fileExists: path ]]
