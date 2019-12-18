web-services
createWebServer
	"create the web service"
	webServer := (WebServer reset default) 
		listenOn: ((self port) asInteger)
		interface: (((self host) splitOn: '.') collect: [:el | el asInteger] )  .
	"logging to the Transcript "
	webServer accessLog: Transcript . 
	webServer