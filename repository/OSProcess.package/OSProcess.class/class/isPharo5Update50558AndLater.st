version dependent
isPharo5Update50558AndLater
	"True if this image is a pharo of major version 5 at upldate 50558 or greater"
	
	"OSProcess isPharo5Update50558AndLater"

	Smalltalk
		at: #SystemVersion
		ifPresent: [:cls | ((cls canUnderstand: #type) and: [ cls canUnderstand: #major ])
			ifTrue: [ ^ ((cls current perform: #type) = 'Pharo' and: [ (cls current perform: #major) >= 5 ])
						and: [ cls current  highestUpdate >= 50558]]].
	^false
