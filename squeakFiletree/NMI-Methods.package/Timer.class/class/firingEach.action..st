initialize-release
firingEach: aIntegerMilliseconds action: aBlock
	"Define a timer object with each aIntergerMilliseconds execute the code in aBlock."
	|out| 
	out := Timer new.
	out timeSlot: aIntegerMilliseconds.
	out action: aBlock.
	^ out 