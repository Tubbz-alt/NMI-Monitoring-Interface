private - IOHandle
handleFromFileStream: aFileStream

	UseIOHandle
		ifTrue: [^ aFileStream ioHandle perform: #asSQFileStruct]
		ifFalse: [^ aFileStream fileID]
