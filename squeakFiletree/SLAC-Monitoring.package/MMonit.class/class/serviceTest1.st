selftest-web-query
serviceTest1
	"
	MMonist serviceTest1. [CTRL-p]  
	"
	^ (WebClient httpGet:'http://localhost:3001/test1') content. 