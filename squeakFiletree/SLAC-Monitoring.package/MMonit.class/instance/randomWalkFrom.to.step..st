web-helper-outputgen
randomWalkFrom: aDate1 to: aDate2 step: aDuration
	"Return a RandomWalk starting at aDate1 ending at aDate2, each point 
	in time is distant aDuration. 
	
	Times is a Unix Epoch in milliseconds. Each values in the output is a couple
	out := [ [value time], [value time)] ....  ].   "
		
		|out lastVal tTmp| 
		
		"Check this condition on date, otherwise nothing works."
		self assert: (aDate1 < aDate2). 
		tTmp := aDate1. 
		lastVal := 0.
		out := OrderedCollection new. 
		[tTmp < aDate2] whileTrue: [
			lastVal := lastVal + (#(-1 1) atRandom).
			out add: {lastVal. ((tTmp asUnixTime) * 1000)}.
			tTmp := tTmp + aDuration
		].
				
	^ out 

