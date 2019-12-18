query
getListOfServices	
	"get list of services from MMoint and return it as list of MonitHostService. "

	|json out ms|
	"get the values of insterest as JSON object"
	json := self mmonit getHostDetails: self. 
	
	out := OrderedCollection new. 
	
	(((json at: 'records') at: 'host') at: 'services') do: [ :ser |
		ms := MonitHostService new. 
		ms name: (ser at: 'name').
		ms id: (ser at: 'id').
	   ms status: (ser at: 'status').
	   ms type: (ser at: 'type').
     ms host: self. 
		out add: ms.
	].
	
	^out .	
