accessing
countBroken
	"Return a list of dictionaries of all services and hosts down for each group.
	The dictionary keys are the group names. "
	|out|
	out := Dictionary new.  
	self groupList do: [ :mGroup | 
		out add: (mGroup name) -> (mGroup countBroken).
	].
	^ out
