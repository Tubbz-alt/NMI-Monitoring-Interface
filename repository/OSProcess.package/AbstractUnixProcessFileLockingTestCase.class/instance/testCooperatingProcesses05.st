testing
testCooperatingProcesses05
	"Two cooperating Squeak processes using file region locking to coordinate their
	writes to a shared file."

	"(self selector: #testCooperatingProcesses05) run"

	| result |
	result := self
		doRemote:
			[OSProcess thisOSProcess stdOut nextPutAll: 'starting remote squeak requesting lock on 100 to 120';
				nextPut: Character lf.
			(self tryUntil: [(accessor lockFile: fileStream from: 100 to: 120) notNil]) ifNil: [self quitImage].
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak lock acquired on 100 to 120'; nextPut: Character lf; flush.
			fileStream position: 100.
			fileStream nextPutAll: 'THIS '; flush.
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak releasing lock on 100 to 120'; nextPut: Character lf; flush.
			accessor unlockFile: fileStream from: 100 to: 120.
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak lock released on 100 to 120'; nextPut: Character lf; flush.
			delay wait.
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak requesting lock on 108 to: 120'; nextPut: Character lf; flush.
			self tryUntil: [(accessor lockFile: fileStream from: 108 to: 120) notNil].
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak lock acquired on 108 to: 120'; nextPut: Character lf; flush.
			fileStream position: 108.
			fileStream nextPutAll: 'A '; flush.
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak releasing lock on 108 to: 120'; nextPut: Character lf; flush.
			accessor unlockFile: fileStream from: 108 to: 120.
			OSProcess thisOSProcess stdOut nextPutAll: 'remote squeak lock released on 108 to: 120'; nextPut: Character lf; flush.
			delay wait.
			self quitImage]
		doLocal:
			[OSProcess thisOSProcess stdOut nextPutAll: 'starting local squeak requesting lock on 104 to: 120';
				nextPut: Character lf.
			self assert: (self tryUntil: [(accessor lockFile: fileStream from: 104 to: 120) notNil]).
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak lock acquired on 104 to: 120'; nextPut: Character lf; flush.
			fileStream position: 105.
			fileStream nextPutAll: 'IS '; flush.
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak releasing lock on 104 to: 120'; nextPut: Character lf; flush.
			accessor unlockFile: fileStream from: 104 to: 120.
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak lock released on 104 to: 120'; nextPut: Character lf; flush.
			delay wait.
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak requesting lock on 108 to: 120'; nextPut: Character lf; flush.
			self tryUntil: [(accessor lockFile: fileStream from: 108 to: 120) notNil].
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak lock acquired on 108 to: 120'; nextPut: Character lf; flush.
			fileStream position: 110.
			fileStream nextPutAll: 'TEST '; flush.
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak releasing lock on 108 to: 120'; nextPut: Character lf; flush.
			accessor unlockFile: fileStream from: 108 to: 120.
			OSProcess thisOSProcess stdOut nextPutAll: 'local squeak lock released on 108 to: 120'; nextPut: Character lf; flush.
			delay wait].
	self tryUntil: [(accessor lockFile: fileStream from: 100 to: 140) notNil].
	fileStream position: 100.
	result := fileStream next: 14.
	accessor unlockFile: fileStream from: 100 to: 140.
	self assert: result = 'THIS IS A TEST'
