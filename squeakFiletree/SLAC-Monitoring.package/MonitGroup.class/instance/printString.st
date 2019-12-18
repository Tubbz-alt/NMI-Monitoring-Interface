printing
printString
	"Defines how to print an MonitGroup object"
	|out|
	out := '{1} - {2} ' format: {self class. name.  }	.
	^ out 