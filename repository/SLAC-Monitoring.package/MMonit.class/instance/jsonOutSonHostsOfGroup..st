web-helper-outputgen
jsonOutSonHostsOfGroup: aString
	"Prepare the output to be served by the web server when it is requested
	 the list of hosts in a particular group. 
	
	aString is a group name. So for example 'daq'.
	
		"
		|templateStructure outStructure out theGroup| 
		
			templateStructure := '[
  {
    "columns":[
      {"text":"hostname","type":"string"},
      {"text":"status","type":"string"},   
      {"text":"cpu","type":"number"},
      {"text":"mem","type":"number"},
     {"text":"color","type":"number" }
    ],
    "rows":[ ["SE",123], ["DE",231], ["US",321]  ],
    "type":"table"
   } ]'.
  
	"Import the tempate as a Smalltalk data structure"
	outStructure := STON fromString: templateStructure. 

   "Generate the list of rows, which is dinamic"
	out := OrderedCollection new. 
	"Get the group of interest"
	theGroup := (self groupList select: [ :gr| gr name = aString]) at: 1. 
   theGroup hosts do: [ :host| 
		|tmp|
		tmp := OrderedCollection new.
		tmp add: ('{1}' format: {host hostname} ).
		tmp add: host status.
		tmp add: host cpu.
		tmp add: host mem.
		tmp add: host ledColorAsNumber.  
		out add: tmp. 
	].
 
  "substitute list of rows into the template string."
  (outStructure at: 1) at: 'rows' put: out.

	"convert outStructure into a JSONstring."
   out := outStructure asJsonString .

	^ out 
	
	
