version dependent
snapshot: save andQuit: quit
	"After Squeak version 3.6, #snapshot:andQuit: was moved to SmalltalkImage. Cuis has a
	different but distinct method signature so check for that first."
	
	"self snapshot: false andQuit: true"
	
	(Smalltalk respondsTo: #snapshot:andQuit:embedded:clearAllClassState:)
		ifTrue: [ "Cuis image"
			^ Smalltalk
				perform: #snapshot:andQuit:embedded:clearAllClassState:
				withArguments: { save . quit . false . false } ].
	^ ((Smalltalk classNamed: 'SmalltalkImage')
		ifNil: [^ Smalltalk
				perform: #snapshot:andQuit:embedded:
				withArguments: { save . quit . false } ])
			current snapshot: save andQuit: quit