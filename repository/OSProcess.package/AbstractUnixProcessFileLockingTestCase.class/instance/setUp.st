running
setUp

	(self respondsTo: #timeout: ) "Recent Squeak images with test case timeout"
		ifTrue: [self perform: #timeout: with: 30].
	delay := Delay forMilliseconds: 150.
	accessor := ThisOSProcess accessor.
	OSProcess deleteFileNamed: 'junkfile'.
	fileStream := OSProcess fileNamed: 'junkfile'.
	1000 timesRepeat: (fileStream nextPutAll: 'hello world ').
