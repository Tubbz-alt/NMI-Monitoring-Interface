query
ledColorAsNumber 
	" 
	To color cells Grafana wants them to be numberic. 
	So we will define this translation: 
	
	YELLOW -> 10
	RED -> 20
	GREEN -> 0 
	GRAY -> -1 
	
	We choose different values because there may be requested other statuses 
	in the future. 

	I case the we don't find something that matches we return with 'nil'.

	"
	|tmp|
   tmp := self ledColor.
	(tmp = (Color red)) ifTrue: [^ 20].
	(tmp = (Color yellow)) ifTrue: [^ 10].
	(tmp = (Color green)) ifTrue: [^ 0].
	(tmp = (Color gray)) ifTrue: [^ -10].
	^ nil 
	
	