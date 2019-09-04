compatibility
fileNamed: path
	^ self useFileMan
		ifTrue: [ | entry |
			entry := ((Smalltalk at: #FileEntry) pathName: path) assureExistence.
			entry fileAccessor privateWriteableFile: entry]
		ifFalse: [ FileStream fileNamed: path ]
