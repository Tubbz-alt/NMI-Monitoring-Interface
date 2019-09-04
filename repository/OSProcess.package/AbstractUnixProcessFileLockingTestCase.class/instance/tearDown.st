running
tearDown

	| d |
	OSProcessAccessor emulateWin32FileLocking: initialCompatibilitySetting.
	d := Delay forMilliseconds: 50.
	fileStream close.
	remoteProcess ifNotNil:
		[remoteProcess terminate.
		[remoteProcess isComplete] whileFalse: [d wait].
		remoteProcess := nil]
