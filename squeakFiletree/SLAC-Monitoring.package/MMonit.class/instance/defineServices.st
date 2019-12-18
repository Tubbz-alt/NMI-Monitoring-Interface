web-services
defineServices
"
Test with something linke this: 

Client test access to the function recently defined.
(WebClient httpGet:'http://localhost:3001/test1') content. 

"
	|ws|
	ws := webServer. 
	
	"just a simple test service. "
	ws addService:'/test1' action: [ :req | 
	req send200Response: 'Hello World'   ].

	"/search calls"
	ws  addService:'/search' action: [ :req |
	|out tmp targetStr|	
		Transcript show: ('/search --- content :  ', req content asString, req content ). 
		"default output"
		out := '["foo","bar","baz"]'.
		"out gets different value if something particular is passed into req "
	   (req content) ifNotNil: [
				tmp := STON fromString: req content.
				targetStr := (tmp at:'target') withBlanksTrimmed . 
				(targetStr = 'askGroupNames' ) ifTrue: [
					out := '["gr1","gr2","gr3"]'.
					].
		].
	
	req send200Response:out contentType: 'application/json'.
	].

	"/query calls"
	". this call is protected by a mutex to avoid that cache data reading happens
		at the same time of MMonit data refresh. "
   ws addService:'/query' action: [ :req | 
		
      |tmp  out targetStr reqParsed date0 date1 re|
      "date di inizio e fine della finestra per la time-series, dove rilevante."
      date0 := nil. 
      date1 := nil.

	   Transcript show: req content. 
	
		"protect access to cached data with a Mutex Semaphore."
     	self cacheMutex critical: [ 
		
   	"default output to send in case nothing has been found"
	   out :='[]'.
"	   self halt."
	   "out gets different value if something particular is passed into req "
	   (req content) ifNotNil: [
				reqParsed := STON fromString: req content.
				tmp := ((reqParsed at: 'targets') at: 1).
				targetStr := (tmp at:'target') withBlanksTrimmed .
								
				"get the date ini and end of the time window, if available. "
				(reqParsed at: 'range') ifNotNil: [
					date0 := DateAndTime fromString: ((reqParsed at: 'range') at: 'from').
					date1 := DateAndTime fromString: ((reqParsed at: 'range') at: 'to'). 
					].
				
				"Grafana ask the list of groups" 
				(targetStr = 'groupList' ) ifTrue: [
					"compute the output json to return as answer."
					out := self jsonOutGroupList.
					].
				
				"Grafana asks the host list of a certain group."
				re :=  'group->(.*)' asRegex . 
				(re search: targetStr)  ifTrue: [
					|theGroupName theGroup|
					theGroupName := (re subexpression: 2) withBlanksTrimmed . 
					theGroup :=  (self groupList select: [ :gr| gr name = theGroupName]) at: 1. 
					"compute the output json to return as answer"
					out := self jsonOutSonHostsOfGroup: theGroup name.
					].
				
				"Grafana asks the host list of a certain group."
				re :=  'host->(.*)' asRegex . 
				(re search: targetStr)  ifTrue: [
					|theHostName theHost|
					theHostName := (re subexpression: 2) withBlanksTrimmed . 
				"	theHost :=  (self groupList select: [ :gr| gr name = theGroupName]) at: 1. "
					theHost := self hostDiz at: theHostName.  
					"compute the output json to return as answer"
			"		out := self jsonOutSonHostsOfGroup: theGroup name."
					out := self jsonOutServicesOfHost: theHostName. 
					].
		
				"Grafana asks random walk timeseries data --- this is a test, of course."
				re :=  'rwalk' asRegex . 
				(re search: targetStr)  ifTrue: [					
    			Transcript cr; show: '----> requrested RANDOM-WALK timeseries'; cr. 		
		     out := self jsonOutTest2RandomWalksFrom: date0 to: date1.  				
					].
		
				"Grafana asks history of services down."
				re :=  'servicesDown' asRegex . 
				(re search: targetStr)  ifTrue: [					
    			Transcript cr; 
			     show: ('----> requrested SERVICES-DOWN timeseries from: {1} to: {2}' 
			                 format: {date0 asLocal. date1 asLocal}); cr. 		
		     out := self jsonOutServicesDownFrom:  date0 to: date1.  				
					].
		
				"Grafana asks history of hosts down."
				re :=  'hostsDown' asRegex . 
				(re search: targetStr)  ifTrue: [					
    			Transcript cr; 
			     show: ('----> requrested HOTSTS-DOWN timeseries from: {1} to: {2}' 
			                 format: {date0 asLocal. date1 asLocal}); cr. 		
		     out := self jsonOutHostsDownFrom:  date0 to: date1.  				
					].


						
				].
			].

	"send out the JSON string."
	req send200Response: out.
	].

	
	