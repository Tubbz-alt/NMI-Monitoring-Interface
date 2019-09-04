query
updateDataFromMMonit
	"get new data from monit and fill in the local objects. "
	self	updateGroupsList.
	self updateHostsList. 
	self updateHostGroupRelations .
		

	