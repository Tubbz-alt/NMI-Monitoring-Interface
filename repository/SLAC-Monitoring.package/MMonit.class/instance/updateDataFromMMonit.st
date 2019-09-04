query
updateDataFromMMonit
	"get new data from monit and fill in the local objects. 
	. The access to the cached data is protected by the 'cacheMutex' semaphore.
	"
	self cacheMutex critical: [
		self updateGroupsList.
		self updateHostsList. 
		self updateHostGroupRelations .
	].


	