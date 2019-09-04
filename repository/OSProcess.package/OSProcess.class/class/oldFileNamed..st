compatibility
oldFileNamed: path
	^ self useFileMan
		ifTrue: [ | entry |
			entry := (Smalltalk at: #FileEntry) pathName: path.
			entry fileAccessor privateWriteableFile: entry]
		ifFalse: [ FileStream fileNamed: path ]
