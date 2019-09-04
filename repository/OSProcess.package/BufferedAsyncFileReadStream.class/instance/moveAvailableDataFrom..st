read ahead buffer
moveAvailableDataFrom: sqFile

	| count bufferSize buffer |
	(readBuffer notNil and: [readBuffer size > self readBufferMemoryWarningThreshold])
		ifTrue: [self notify: 'buffer size ', readBuffer size asString.
			^(Delay forSeconds: 2) wait].
	bufferSize := self readAheadChunkSize.
	buffer := String new: bufferSize.
	count := self readAvailableDataFrom: sqFile into: buffer.
	count > 0
		ifTrue:
			[count == bufferSize
				ifTrue:
					[self appendAllToBuffer: buffer]
				ifFalse:
					[self appendAllToBuffer: (buffer copyFrom: 1 to: count)]]
		ifFalse:
			[(self closed or: [OSProcess accessor isAtEndOfFile: self ioHandle])
				ifTrue:
					[self disableEventHandling]]
