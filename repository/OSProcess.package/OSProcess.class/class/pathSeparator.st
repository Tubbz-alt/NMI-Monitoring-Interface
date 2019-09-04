compatibility
pathSeparator

	^ self useFileMan
		ifTrue: [(Smalltalk at: #FileIOAccessor) default slash]
		ifFalse: [self useFileSystem
			ifTrue: [((Smalltalk at: #DiskStore) current perform: #delimiter) asString]
			ifFalse: [(Smalltalk at: #FileDirectory) slash]]
