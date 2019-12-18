web-helper-outputgen
jsonOutServicesOfHost: aString
	"Prepare the output to be served by the web server when it is requested
	 the list of services of a certain host .
	 aString : the hostname. "
	
	|templateStructure outStructure out theServicesList| 
		
	templateStructure := '[
  {
    "columns":[
	    {"text":"name","type":"string"},   
      {"text":"id","type":"string"},
      {"text":"type","type":"string"},
      {"text":"status","type":"string"},
	   {"text":"color","type":"integer"}
    ],
    "rows":[ ["SE",123], ["DE",231], ["US",321]  ],
    "type":"table"
   } ]'.
  
	"Import the tempate as a Smalltalk data structure"
	outStructure := STON fromString: templateStructure. 

   "Generate the list of rows, which is dinamic"
	out := OrderedCollection new. 

	"Get the group of interest"
	theServicesList := (self hostDiz at: aString) getListOfServices . 
   theServicesList do: [ :service| 
		|tmp|
		tmp := OrderedCollection new.
		tmp add: (service name).
	   tmp add: (service id) asString. 
		tmp add: service type.  
		tmp add: service status.  
		tmp add: (((service status) = 'OK') ifTrue: 0 ifFalse: 1 ). 
		out add: tmp. 
	].

  "substitute list of rows into the template string."
  (outStructure at: 1) at: 'rows' put: out.

"	self halt. "
	
	"convert outStructure into a JSONstring."
   out := outStructure asJsonString .

	^ out 
	
