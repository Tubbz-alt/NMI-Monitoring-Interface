web-helper-outputgen
jsonOutTest2RandomWalksFrom: aDate1 to: aDate2 
	"Return in output a 100 points RandomWalk from aDate1 and aDate2. 
	
	 The timeseries will be in JSON format and respecting the syntax 
	 that Grafana expects.  
		"
		
		|templateStructure dur rw1 rw2 outStruc d1 d2 out| 
		
		"This is the tipical structure of the data expected by Grafana for a timeseries. 
		It is here just for reference, it is not used. "
		templateStructure := '[
  {
    "target":"upper_75",            // The field being queried for
    "datapoints":[
      [622,1450754160000],       // Metric value as a float , unixtimestamp in milliseconds
      [365,1450754220000]
    ]
  },
  {
    "target":"upper_90",
    "datapoints":[
      [861,1450754160000],
      [767,1450754220000]
    ]
  }
]'.
		
"   dur := Duration seconds: ((((aDate2 - aDate1)    
asSeconds)	/ 1000.0)	floor).  		
"		
	"The minimum dur must be 1 seconds."
   dur := Duration seconds: (((((aDate2 - aDate1) asSeconds) / 1000.0) floor) max: 1).
		
   "Buld the two random walk objects: rw1 and rw2"
   rw1 := self randomWalkFrom: aDate1 to: aDate2 step: dur. 
   rw2 := self randomWalkFrom: aDate1 to: aDate2 step: dur. 

	"Build the structure to be converted later into JSON"
	outStruc := OrderedCollection new. 
	d1 := Dictionary new. 
	d2 := Dictionary new. 
	d1 add: 'target' -> 'rwalk1'.
	d2 add: 'target' -> 'rwalk2'.
	d1 add: 'datapoints' -> rw1.
	d2 add: 'datapoints' -> rw2.
	outStruc add: d1.
	outStruc add: d2.  
			
	"convert outStructure into a JSONstring."
	out := outStruc asJsonString. 

	^ out 
	
	
