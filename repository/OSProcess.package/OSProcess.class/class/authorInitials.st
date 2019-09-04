sUnit
authorInitials
	"Get the author initials from the system."

	((Smalltalk respondsTo: #metacelloPlatformAttributes)
		and: [ 
			((Smalltalk perform: #metacelloPlatformAttributes) includes: #'pharo3.x')
				or: [ (Smalltalk perform: #metacelloPlatformAttributes) includes: #'pharo2.x' ] ])
		ifTrue: [ ^ (Smalltalk at: #Author) fullName select: [ :c | c isUppercase ] ].
	^ (Smalltalk at: #Utilities) authorInitials