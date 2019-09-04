pipe open
makePipeHandles
	"Create a pipe, and answer an array of two IO accessors for the pipe 
	reader and writer."

	"OSProcess accessor makePipeHandles"

	| p |
	p := self primCreatePipe.
	p isNil
		ifFalse: [ ^ p collect: [ :e | self ioAccessorFromSQFile: e ] ].
	^ nil