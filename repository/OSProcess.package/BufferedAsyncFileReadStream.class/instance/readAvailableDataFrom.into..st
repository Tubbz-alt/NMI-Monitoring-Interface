read ahead buffer
readAvailableDataFrom: sqFile into: buffer
	"Some implementations of the read primitive may read character by character
	from standard input. Handle that case by looping while data available. Answer
	the number of bytes read into the buffer."

	| bytesRead |
	bytesRead := 0.
	[ | count |
		[count := self primRead: sqFile
				into: buffer
				startingAt: 1 + bytesRead
				count: self readAheadChunkSize - bytesRead]
			on: Error	"Could fail if closed"
			do: [count := 0].
	bytesRead := bytesRead + count.
	count > 0] whileTrue.
	^ bytesRead.
