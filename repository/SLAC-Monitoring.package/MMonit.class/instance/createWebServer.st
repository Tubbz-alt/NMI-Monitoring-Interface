web-services
createWebServer
	"create the web service"
	webServer := (WebServer reset default) listenOn: 3001 interface: #(127 0 0 1).
	"logging to the Transcript "
	webServer accessLog: Transcript . 
	webServer