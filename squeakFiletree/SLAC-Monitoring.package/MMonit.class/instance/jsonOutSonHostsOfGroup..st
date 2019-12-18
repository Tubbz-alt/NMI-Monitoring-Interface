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
	"The first row is a dynamic links that permits to go back"
	
"	out add: ( OrderedCollection 
		with: '<a href=""https://pswww.slac.stanford.edu/system/grafana-dev/d/SP7d7fcWz/monit-interface?orgId=1"">aa Go BACK</a>' with: '' with: '0' with: '0' with: '100'
	).
"	
	
	"Get the group of interest. 
	 we don't collect hosts whose status is 'inactive'. "
	theGroup := (self groupList select: [ :gr| gr name = aString]) at: 1. 
   theGroup hosts do: [ :host| 
		|tmp|
		tmp := OrderedCollection new.
		tmp add: ('<a href=" https://pswww.slac.stanford.edu/system/grafana-dev/dashboard/script/scriptedServicesList.js?orgId=1&group={2}&host={1}&fullscreen&panelId=2">{1}</a>' format: {host hostname. theGroup name.} ).
		tmp add: host status.
		tmp add: host cpu.
		tmp add: host mem.
		tmp add: host ledColorAsNumber.  
		"we are not interested in 'Inactive' items "
		((host status) = 'Inactive') ifTrue: nil ifFalse:  [out add: tmp]. 
	].

	"Add last element"
"	out add: ( OrderedCollection 
		with: '<a href=""https://pswww.slac.stanford.edu/system/grafana-dev/d/SP7d7fcWz/monit-interface?orgId=1"">zzz Go BACK</a>' with: '' with: '0' with: '0' with: '100'
	). 
"
  "substitute list of rows into the template string."
  (outStructure at: 1) at: 'rows' put: out.

	"convert outStructure into a JSONstring."
   out := outStructure asJsonString .

	^ out 
	
	
