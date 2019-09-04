child process management
restartChildWatcherProcess
	grimReaper notNil
		ifTrue: [ grimReaper terminate.
			grimReaper := nil ].
	self grimReaperProcess