# Monitoring-Interface

This project provides a way to visualize <b>Monit</b> data in <b>Grafana</b>. 

This software is fully objective (not imperative), the main object is called <b>MMonit</b>. This can create confusion with the MMonit server so we will refer to the locally implemented suff as the <b>MMonit-Object</b>. 

MMonit-object listens on port: <b>3001</b>. 

MMonit-object calls MMonit each minute and updates its knowledge about LCLS groups and hosts. The data about these 2 elements is always cached. At more finer graind level of detail, e.g. data about Processes is updated on demand on users specific query.

Grafana asks stuff to MMonit-object considering it a JSON datasource. MMonit-object answers immediately using its cached knowledge. In the case of services MMoni-objec calls MMonit, parse the results re-arrange them and passes them back to Graphana. 

Grafana asks stuff to MMonit-object only when a user visit the proper dashboards / plugins. Or when a dashboard/plugin is kept open and gets updated automatically by Grafana.

Here follows a [video](https://www.youtube.com/watch?v=CA1ShjhlXCw) illustrating what has been achieved at 04-Sep-2019. The software is still very much in the experimental phase, it may go down, I may bring it down without notice. 

## How to try it out 

As of 17 Sept 2018 you can see the application running visiting: pswww.slac.stanford.edu -> Graphana Monitoring (test) -> Monit Interface dashboard. 

<b>CAVEAT</b>. I am working often on the application. This is experimental software, I change it when it is running. You may see wired stuff on your screen untill the development phase is over. 


## Installation and configuration 

<li>
<li> We suppose here the installation is done in our local machine <b>psmetric01</b>. 
<li> <b>MMonit</b> is listening on XXXX  port XXXX
<li> <b>Grafana</b> is waiting connection on XXX port XXXX
</li>

### To run the grafana-mmonit interface do 

This program runs in a GUI so it will be a little more elaborate than usaul to get it running. The upside of the story is that this way of coding let me change/debug the program while it is running with minimal effort. 
<ul>
<li> Go to the appropriate directory in psmetric01
  <code>
  $> cd /reg/neh/home/nmingott/bin/Squeak5.2
  </code>
<li> We need to ensure that vncserver is running on port 5902 
<code>
$> vncserver -list 
</code>
<li> If it is not runnig do
  <code>
$> vncserver :2 
  </code>
  <li> Then set environment properly in such a way that X goes to VNC 
    <code>
      $> export DISPLAY=":2"
    </code>
   <li> Run the proper program
     <code>
       $> nohup ./mmonit-grafana-interface
     </code>
</ul>
Now go to another machine where you have a display with XWindows running, make an ssh tunnel from port psmetric01:5902 to yourmachine:15902 and run
<code>
  $> vncviewer localhost:15902 
  </code>


### To test the grafana-mmonit-interface is up and running from the shell do

<p>
You may not see immediately data in pswww because it take a while to build a minimal history. 
</p>

<p>
You can check the status of the program watching at what you see written in <b>Transcript</b> window. You should see a trace of each call to Monit and a trace of each call received from pswww.  
</p>

OLD:
<code>
foo@psmetric01 $> curl http://localhost:3001/test1
Hello World
</code> 









