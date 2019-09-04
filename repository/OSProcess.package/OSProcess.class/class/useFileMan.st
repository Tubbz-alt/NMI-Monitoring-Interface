version dependent
useFileMan
	"If true use FileMan for directory and file access. See senders for methods with file
	system dependencies."

	^ Smalltalk hasClassNamed: #FileIOAccessor