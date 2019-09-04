initialize-release
initialize
	"ThisOSProcess initialize"

	OSProcess initialize.	"required to ensure the change sets file in smoothly"
	AttachableFileStream initialize.
	OSProcessAccessor initialize.
	ChildListSize := 20.	"list will be pruned to this size, except for any children still running"
	self initializeThisOSProcess.
	self isPharo5Update50558AndLater
		ifFalse: [ Smalltalk addToStartUpList: ThisOSProcess.
			Smalltalk addToShutDownList: ThisOSProcess ]
		ifTrue:
			[ (Smalltalk at: #SessionManager) default
				perform: #registerToolClassNamed:
				with: ThisOSProcess name ]
