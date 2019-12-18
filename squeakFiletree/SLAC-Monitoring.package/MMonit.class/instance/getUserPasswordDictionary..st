authentication
getUserPasswordDictionary: aFilename
	"Read the file un 'aFilename' and return a dictionary with the associations username -> password. 
	
	PASSWORD FILE FORMAT EXAMPLE
	---------------------------------------------------------- 
     # asdfasdf bla blab bka
     # bla bla b
     username tizio password cAio 
     username babbo password NatalE
	-----------------------------------------------------------	
 	'"
	|diz reg str|
	diz := Dictionary new. 
	str := FileStream readOnlyFileNamed: aFilename. 
	reg := 'username(\s+)(\S+)(\s+)password(\s+)(\S+)'  asRegex.
	[str atEnd] whileFalse: [
		|line|
		line := str nextLine withBlanksTrimmed. 
		(reg matches: line) ifTrue:
			[ reg search: line.  
			  diz add: (reg subexpression: 3) -> (reg subexpression: 6) ]. 
	].
	str close.
	^ diz 
	 
