/* global _ */

/*
 * Complex scripted dashboard
 * This script generates a dashboard object that Grafana can load. It also takes a number of user
 * supplied URL parameters (in the ARGS variable)
 *
 * Return a dashboard object, or a function
 *
 * For async scripts, return a function, this function must take a single callback function as argument,
 * call this callback function with the dashboard object (look at scripted_async.js for an example)
 */

'use strict';

// accessible variables in this scope
var window, document, ARGS, $, jQuery, moment, kbn;

// Setup some variables
var dashboard;

// All url parameters are available via the ARGS object
var ARGS;

// Initialize a skeleton with nothing but a rows array and service object
dashboard = {
  rows : [],
};

// Set a title
dashboard.title = 'Scripted Host list';

// Set default time
// time can be overridden in the url using from/to parameters, but this is
// handled automatically in grafana core during dashboard initialization
dashboard.time = {
  from: "now-6h",
  to: "now"
};

var rows = 1;
var seriesName = 'argName';
var groupName = 'UNDEFINED';

if(!_.isUndefined(ARGS.rows)) {
  rows = parseInt(ARGS.rows, 10);
}

// if(!_.isUndefined(ARGS.name)) {
//   seriesName = ARGS.name;
// }

if(!_.isUndefined(ARGS.group)) {
   // seriesName = ARGS.name;
   groupName = ARGS.group.trim();
}

for (var i = 0; i < rows; i++) {

  dashboard.rows.push({
    title: 'Scripted Table',
    height: '500px',
    "panels": [
    {
      "columns": [],
      "datasource": "SimpleJson-Squeak-3001",
      "description": "This panel will be the base to automatize next ones. \n",
      "fontSize": "100%",
      "gridPos": {
        "h": 9,
        "w": 23,
        "x": 0,
        "y": 0
      },
      "id": 2,
      "options": {},
      "pageSize": null,
      "scroll": true,
      "showHeader": true,
      "sort": {
        "col": 0,
        "desc": false
      },
      "styles": [
        // {
        //   "alias": "",
        //   "pattern": "hostname",
        //   "type": "string",
	//   "mappingType": 1,
        // },
        // {
        //   "alias": "",
        //   "pattern": "status",
        //   "type": "string",
	//   "mappingType": 1,
        // },
        // specifiche per la cella "cpu" di carico in cpu.
        {
          "alias": "",
          "pattern": "cpu",
          "type": "number",
	  "mappingType": 1,
	  "unit": "short",
          "colors": [
            "rgba(50, 172, 45, 0.97)",     
            "rgba(237, 129, 40, 0.89)",
            "rgba(245, 54, 54, 0.9)",
          ],
	  "colorMode": "cell",
          "thresholds": [
            "33",
            "66"
          ],
        },
        // specifiche per la cella di "mem" di memoria occupata. 
        {
          "alias": "",
          "pattern": "mem",
          "type": "number",
	  "mappingType": 1,
	  "unit": "short",
          "colors": [
            "rgba(50, 172, 45, 0.97)",     
            "rgba(237, 129, 40, 0.89)",
            "rgba(245, 54, 54, 0.9)",
          ],
	  "colorMode": "cell",
          "thresholds": [
            "33",
            "66"
          ],
        },
        // {
        //   "alias": "",
	//   "mappingType": 1,
        //   "pattern": "mem",
        //   "type": "number",
	//   "unit": "short",
	//   "decimals": 1
        // },
        {
          "alias": "",
	  "mappingType": 1,
          "pattern": "status",
          "type": "string",
        },
        {
          "alias": "",
          "colorMode": "row",
          "colors": [
            "rgba(100, 100, 100, 0.9)",    // questo e' grigio, il 4 colore aggiunto a mano. 
            "rgba(50, 172, 45, 0.97)",     // da interfaccia si possono mettere solo 3 colori ! 
            "rgba(237, 129, 40, 0.89)",
            "rgba(245, 54, 54, 0.9)",
          ],
          "decimals": 0,
          "mappingType": 1,
          "pattern": "color",
          "thresholds": [
	    "-1",
            "0",
            "10",
            "20"
          ],
          "type": "number",
          "unit": "short"
          // , "valueMaps": [
          //   {
          //     "text": "All Fine",
          //     "value": "0"
          //   },
          //   {
          //     "text": "Some services are not working",
          //     "value": "10"
          //   },
          //   {
          //     "text": "The host is down.",
          //     "value": "20"
          //   },
          //   {
          //     "text": "Host inactive",
          //     "value": "-10"
          //   }
          // ]
        }
      ],
      "targets": [
        {
          "refId": "A",
          // "target": "group->daq",
          "target": `group->${groupName}`,
          "type": "table"
        }
      ],
      "timeFrom": null,
      "timeShift": null,
      "title": `Host List for Group: ${groupName}`,
      "transform": "table",
      "type": "table"
    }
  ]
 
  });
}


return dashboard;
