compatibility
defaultPathString

	^ self useFileMan
		ifTrue: [((Smalltalk at: #DirectoryEntry) perform: #currentDirectory) printString]
		ifFalse: [self useFileSystem
			ifTrue: [(((Smalltalk at: #Path) perform: #workingDirectory) perform: #asFileReference) pathString]
			ifFalse: [(Smalltalk at: #FileDirectory) default pathName]]
