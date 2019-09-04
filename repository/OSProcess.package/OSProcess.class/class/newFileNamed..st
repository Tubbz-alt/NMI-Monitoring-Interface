compatibility
newFileNamed: path
	^ self useFileMan
		ifTrue: [ ((Smalltalk at: #FileEntry) pathName: path) writeStream ]
		ifFalse: [ FileStream fileNamed: path ]
