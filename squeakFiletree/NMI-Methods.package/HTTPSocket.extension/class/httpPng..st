*NMI-Methods
httpPng: url
	"Fetch the given URL, parse it using the PNG reader, and return the resulting Form.
	  URL argument can be a String or an Url. 
	
	Example: 
	 out := HTTPSocket httpPng:  'http://languagegame.org:8080/propella/uploads/99/Squeak-ja.png'.
    out asMorph openInWorld.
	"

	| aUrl data img|
	aUrl := url asUrl. 
	data := aUrl retrieveContents .
	img := (PNGReadWriter on:
 	 					(RWBinaryOrTextStream with: data content) reset binary) nextImage .
	^ img. 
	
	"doc := self httpGet: url."
   "	doc binary; reset." 
	"	(ggg := PNGReadWriter new) setStream: doc."	
"	ggg := PNGReadWriter 
		            on: (RWBinaryOrTextStream  with: doc ).
	^ ggg nextImage."
