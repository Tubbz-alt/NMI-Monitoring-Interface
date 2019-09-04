private - IOHandle
ioAccessorFromSQFile: aByteArray
	"Answer an object which represents an IO channel. If IOHandle is present in
	this image, use it; otherwise just answer aByteArray."

	UseIOHandle
		ifTrue: [^ (Smalltalk at: #IOHandle) perform: #newFromSqFileStruct: with: aByteArray]
		ifFalse: [^ aByteArray]