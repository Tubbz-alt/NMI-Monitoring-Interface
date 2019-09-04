printing
printString
	"Defines how to print an host object"
	|out|
	out := '{1} - {2} ' format: {self class. hostname.  }	.
	^ out 
	
