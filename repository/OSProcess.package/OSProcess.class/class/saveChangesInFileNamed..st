compatibility
saveChangesInFileNamed: aString

	self useFileMan
		ifTrue: [ | newChangesName |
			Smalltalk currentChangesName ifNotNil: [ :oldChangesName |
			Smalltalk closeSourceFiles. "so copying the changes file will always work"
			newChangesName _ self fullNameForChangesNamed: aString.
			(Smalltalk at: #FileIOAccessor) default
				copy: (oldChangesName perform: #asFileEntry) to: (newChangesName perform: #asFileEntry) ] ]
		ifFalse:
			[Smalltalk saveChangesInFileNamed: aString ]