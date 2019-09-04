compatibility
readOnlyFileNamed: path
	^ self useFileMan
		ifTrue: [ | entry |
			entry := (Smalltalk at: #FileEntry) pathName: path.
			entry fileAccessor privateReadOnlyFile: entry]
		ifFalse: [ FileStream readOnlyFileNamed: path ]
