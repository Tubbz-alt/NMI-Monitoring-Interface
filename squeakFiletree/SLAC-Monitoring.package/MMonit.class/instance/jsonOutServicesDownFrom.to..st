web-helper-outputgen
jsonOutServicesDownFrom: aDate1 to: aDate2 
		"Return the structure of down history states for services, in a way that Grafana can parse.
		To make the time series appar well two points are added, one at the exreme left and one at
		extreme right of the time interval.		
		"
		
		|templateStructure outStruc out interestingData outExample outList| 
		
		"outputExample, not used in the code, here only for reference. "
		outExample :=
		'[{"datapoints":[[0,1570211350000],[0,1570211410000],[0,1570211470000],[0,1570211530000]],
			"target":"web"},
		{"datapoints":[[1,1570211350000],[1,1570211410000],[1,1570211470000],[1,1570211530000]],
		  "target":"data-movers"},  
		 .... '.

		
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
	
	"get the SystemDownHost  object only in the time interval [aDate1, aDate2] 
	 .we can count on the fact that this data is naturally sorted in time, by construction.
	 . the first statusData available for the interval [aDate1, aDate2] will be most probaby
	after X > aData1, so we will have the problem of filling the plot on the right part. For
	this reason we fabric a fake observation on the left, which corrsponsds to the true status
	of the system at time aDate1, when it is avialable. 
	"
	interestingData := OrderedCollection new. 
	1 to: (systemDownHistory data size) do: [ :idx | 
			|tmpTime elem|
			elem := systemDownHistory data at: idx.
			tmpTime := elem time.
			((tmpTime >= aDate1) and: [tmpTime <= aDate2]) ifTrue: [
					interestingData add: elem.
				].
			"add the artifact first observation, to fill the timeseries plot on the left."
			(idx >= 2) ifTrue: [ 
				|prevElem prevTime|
			   prevElem := systemDownHistory data at: (idx - 1).
				prevTime := prevElem time. 
				(((prevTime) < aDate1) and: [tmpTime >= aDate1]) ifTrue: [
					interestingData add: prevElem  ].				
				].
		].

	"if interestingData dataset is not empy, but does not contain a point on the right exaclty 
	over aData2, such a point is fabricated to make the time series plot look better." 
	((interestingData size >= 1) and: [interestingData last time < aDate2]) ifTrue: [
		|o1|
		o1 := interestingData last veryDeepCopy.
		o1 time: aDate2.
		interestingData add: o1. 
		].

	"if not interesting data was found fabricat observations occording to last know state of the system"
	 (interestingData size = 0) ifTrue: [
		|lastObs o1 o2| 
	   lastObs := systemDownHistory data last. 
		o1 := lastObs veryDeepCopy.
		o2 := lastObs veryDeepCopy. 
		o1 time: aDate1. 
		o2 time: aDate2.  
		interestingData add: o1; add: o2. 
		].
	
	"sort the data by time, since a few element were added just at the end"
	interestingData := interestingData sorted: [ :a :b | a time <= b time ].
	
	"prepare data structure to collect data, a Dictionary -> Dictionary -> ... [list]"
	outStruc := Dictionary new.
	self groupList do: [ :group | 
		|gName data|
		gName := group name.
		data := Dictionary new. 
		data add: 'target' -> gName; add: 'datapoints' -> (OrderedCollection new). 
		outStruc at: gName put: data.  	
		].
	
	"populate the outStruct data structure" 
	interestingData do: [ :sdStatus |
			|uTime|
			uTime := sdStatus time asUnixTime * 1000.
			sdStatus downDiz keysDo: [ :grName | 
				((outStruc at: grName) at: 'datapoints') add: 
					{(sdStatus downDiz at: grName) at: #servicesDown. uTime}.				
				].
		].
	
	"convert output structure to a list"
	outList := OrderedCollection new. 
	outStruc valuesDo: [ :value |  outList add: value ].
		
	"convert outStructure into a JSONstring."
	out := outList asJsonString. 

	^ out
	
	
