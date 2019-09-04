running
setUp
	OSProcess deleteFileNamed: 'junkfile'.
	fileStream := OSProcess fileNamed: 'junkfile'.