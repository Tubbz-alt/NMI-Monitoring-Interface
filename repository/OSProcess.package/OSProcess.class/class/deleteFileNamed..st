compatibility
deleteFileNamed: fileName
	"Delete the file with the given name."
	
	self useFileMan
		ifTrue: [((Smalltalk at: #FileEntry) pathName: fileName) delete]
		ifFalse: [self useFileSystem
			ifTrue: [ | file sel |
				file := fileName perform: #asFileReference.
				(sel := {#ensureDelete . #ensureDeleted . #delete}
					detect: [ :e | file respondsTo: e ]
					ifNone: [ self error: 'do not know how to ensureDelete' ]) notNil
						ifTrue: [ file perform: sel ].
				(file respondsTo: #ensureDelete)
					ifTrue: [ file perform: #ensureDelete ]
					ifFalse: [ file perform: #ensureDeleted ] ]
			ifFalse:
				[ (Smalltalk at: #FileDirectory) default deleteFileNamed: fileName ] ]