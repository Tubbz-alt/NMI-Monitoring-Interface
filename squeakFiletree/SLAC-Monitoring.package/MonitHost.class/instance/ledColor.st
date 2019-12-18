query
ledColor
	"MMonit associates a color to each host. This function return a Color object 
	 representing MMonit color. 
	 
	 AFAIKSay, the rule to detrmine the color is based on the 'status' variable.
	
	 GRAY : inactive.
	 YELLOW: X out of Y services available
	 GREEN: All X services are available
	 RED :   No report from monit.
	"
	|s|
	"get the status string, trim spaces"
	s := status withBlanksTrimmed . 
	(s prefixMatchesRegexIgnoringCase: 'inactive'  )
		ifTrue: [ ^ (Color gray) ].
	(s prefixMatchesRegexIgnoringCase: '\d+ out of \d+ services are available'  )
		ifTrue: [ ^ (Color yellow) ].
	(s prefixMatchesRegexIgnoringCase: 'no report from monit'  )
		ifTrue: [ ^ (Color red) ].
	(s prefixMatchesRegexIgnoringCase: 'all \d+ services are available'  )
		ifTrue: [ ^ (Color green) ].	
	self error: 'MMonit Host status string was not recognized.'

	