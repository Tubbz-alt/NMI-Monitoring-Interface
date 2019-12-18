query
ledColorAsNumber 
	" 
	To color cells Grafana wants them to be numberic. 
	So we will define this translation: 
	
	NIL --> 0
	YELLOW -> 10
	RED -> 20
	
	We choose different values because there may be requested other statuses 
	in the future. 

	I case the we don't find something that matches we return with 'nil'.

	"
	|tmp|
   tmp := self ledColor.
	(tmp = (Color red)) ifTrue: [^ 20].
	(tmp = (Color yellow)) ifTrue: [^ 10].
	tmp ifNil: [^ 0].
	^ nil 
	
	