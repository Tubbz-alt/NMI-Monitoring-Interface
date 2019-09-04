initialize
initialize

	initialCompatibilitySetting
		ifNil: [initialCompatibilitySetting := OSProcess accessor emulateWin32FileLocking]