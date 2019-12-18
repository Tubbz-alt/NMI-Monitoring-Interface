accessing
equalsStatus: aSystemDownStatus 
	"Compare if the data part of the current SystemDownStatus is equal to the data parst of aSystemDownStatus.
	
	Informally, this checks if two SystemDownStatus objects are the same, ignoring the time at which the status was observed. "
	^ (self downDiz) = (aSystemDownStatus downDiz)
	
