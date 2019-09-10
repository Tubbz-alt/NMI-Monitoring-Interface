*NMI-Methods
basicStoreVersion: aVersion

   " ---------------- NM additions ------------------------------------ "   

	"Before saving / pushing chack if maybe only the README was modified 
	from the Web interface and incorporate the changes. 	
	"
	
	|p1 p2 out1 out2 out3|
	out1 := out2 := out3 := nil.
	
	"$> git fetch origin"
	"we want to compare where we are respect to the online repository."
	self gitCommand: 'fetch origin'.

	"$> git status." 
	p1 := self gitCommandWithOutput: 'status'.
   out1 := p1 output. 	
	
	(out1 includesSubstring: 'Your branch is behind ''origin/master''') ifTrue:[ 
		Transcript  show: 'behind origin/master.'; cr. 
		p2 := self gitCommandWithOutput: 'diff --name-only origin/master'.
		out2 := p2 output. 
		(out2 withBlanksTrimmed = 'README.md') ifTrue: [
			"$> git pull origin master"
			self gitCommand: 'pull origin master'.
			].		
		].
	
	" -------------------------------------------------------------------------------------- "
	
	super basicStoreVersion: aVersion.
	self gitCommand: 'push'.