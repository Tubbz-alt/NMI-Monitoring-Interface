accessing
addIfNew: aSystemDownStatus
	"Add aSystemDownStatus in the 'history' data structure if the data it contains it is not equal to the 
	 last state stored this object history. "
	self history isEmpty ifTrue: [ self add: aSystemDownStatus. ^ self ].
	(self last equalsStatus: aSystemDownStatus) ifFalse: [
		self add: aSystemDownStatus. 	
	].

