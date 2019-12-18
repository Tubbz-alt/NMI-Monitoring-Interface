query
ledColor
	"A group does not have a default web color. 
	
	We define the color of a group in this way.
	----- 
	RED : A group is red when at least one of its host is READ
	
	YELLOW: A goupr is yellow when at least of its host is YELLOW but nono is READ.
	               The logic is that RED is more important then yello and it overrides. 
	------
	
	If there is no color defined for this group, then return 'nil'.
	"
	|redList yellowList |
    redList := self hosts select: [ :host | host isRedLedHost ].
    yellowList := self hosts select: [ :host | host isYellowLedHost ].
	
	(redList size > 0) ifTrue: [ ^ (Color red) ].
	(yellowList size >0) ifTrue: [ ^ (Color yellow)  ]. 
	
	^ nil