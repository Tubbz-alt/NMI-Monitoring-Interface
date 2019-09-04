# Monitoring-Interface

This project provides a way to visualize <b>Monit</b> data in <b>Grafana</b>. 

This software is fully objective (not imperative), the main object is called <b>MMonit</b>. This can create confusion with the MMonit server so we will refer to the locally implemented suff as the <b>MMonit-Object</b>. 

MMonit-object listens on port: <b>3001</b>. 

MMonit-object calls MMonit each minute and updates its knowledge about LCLS groups, hosts and services. 

Grafana asks stuff to MMonit-object considering it a JSON datasource.

Grafana asks stuff to MMonit-object only when a user visit the proper dashboards / plugins. Or, when those objects are open and get updated automatically but Grafana.

Here follows a video illustrating what has been achieved at 04-Sep-2019. <b>XXX TODO ADD LINK XXX</b>. The software is still very much in the experimental phase, it may go down, I may bring it down without notice. 

## How to try it out 

<b>TODO</b> . At the moment the software runs only in my computers. 







