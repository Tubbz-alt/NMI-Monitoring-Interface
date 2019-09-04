data
regionLockFrom: from to: to exclusive: exclusive
	^ OSFileRegionLock onFile: fileStream from: from to: to exclusive: exclusive