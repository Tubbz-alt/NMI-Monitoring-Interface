as yet unclassified
newWithMMonit: aMMonit
	"Create a SystemDownStatus object reading the give MMonit object at the current time."
	|out|
	out := self new.
	out time: DateAndTime now. 
	out downDiz: (aMMonit countBroken). 
	^ out 
		