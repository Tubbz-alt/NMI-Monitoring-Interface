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
		
      |tmp  out targetStr re|
	   Transcript show: req content. 
	
		"protect access to cached data with a Mutex Semaphore."
     	self cacheMutex critical: [ 
		
   	"default output to send in case nothing has been found"
	   out :='[]'.
"	   self halt."
	   "out gets different value if something particular is passed into req "
	   (req content) ifNotNil: [
				tmp := STON fromString: req content.
				tmp := ((tmp at: 'targets') at: 1).
				targetStr := (tmp at:'target') withBlanksTrimmed .
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
				].
			].

	"send out the JSON string."
	req send200Response: out.
	].

	
	