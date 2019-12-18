initialize-release
add: aObject
	"add aObject to the list of elements."

	"If the list is already at maximum capacity, remove oldest element before adding a new one."
	(self data size = self capacity) ifTrue: [
		self data removeFirst.
		].

	self data add: aObject. 		
