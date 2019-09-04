child process management
discardExitedChildren
	"Remove entries for completed child processed from dictionary.
	nb Cuis does not have #select:thenDo:"

	self updateAllMyChildren.
	(childProcessList select: [ :p | p isComplete ])
		do: [ :e | self unregisterChildProcess: e ].
	^ childProcessList
