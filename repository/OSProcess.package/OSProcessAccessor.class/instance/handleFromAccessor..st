private - IOHandle
handleFromAccessor: aByteArrayOrIOAccessor

	UseIOHandle
		ifTrue: [aByteArrayOrIOAccessor isNil
			ifTrue: [^ nil]
			ifFalse: [^ aByteArrayOrIOAccessor perform: #asSQFileStruct]]
		ifFalse: [^ aByteArrayOrIOAccessor]