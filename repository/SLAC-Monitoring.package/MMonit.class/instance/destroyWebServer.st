web-services
destroyWebServer
	|ws|
	ws := webServer.
	ws ifNotNil: [ ws destroy   ]
	