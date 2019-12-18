initialize-release
initialize
	|runnable| 
	runnable := false. 
	process := [[true] whileTrue: [
			runnable ifTrue: [
					self action value.
				].
			(Delay forMilliseconds: (self timeSlot)) wait.
		]
	] forkAt: Processor userBackgroundPriority .
	process suspend. 
	runnable := true.
	
	
	