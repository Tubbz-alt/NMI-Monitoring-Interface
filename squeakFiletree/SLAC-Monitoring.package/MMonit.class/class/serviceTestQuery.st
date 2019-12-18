selftest-web-query
serviceTestQuery
	"
	MMonist serviceTest1. [CTRL-p]  
	"
	^ (WebClient httpGet:'http://localhost:3001/query') content. 