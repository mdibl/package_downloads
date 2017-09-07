# Jenkins

Base directory to store Jenkins downloads scripts and config files

## What do we download from Jenkins -- http://updates.jenkins-ci.org/download/war?

We download the **jenkins.war ** file for the specified release line verion

## Upgrades Frequency

According to Jenkins site (https://jenkins.io/download/lts/) , 
The weekly Jenkins releases deliver bug fixes and new features rapidly to users 
and plugin developers who need them. But for more conservative users, it’s preferable to stick to a release line which 
changes less often and only receives important bug fixes, even if such a release line lags behind in terms of features.

We run the upgrades on demand - meaning whenever the "Manage Jenkins" window shows
a new release alert on our Jenkins server, we toggle an upgrade

See : https://jenkins.mdibl.org/manage

Runs: On demand

## How to upgrade Jenkins
  * Log on to Jenkins server : jenkins.mdibl.org
  * Click on "Manage Jenkins" 
  * if there is a new release suggestion, copy the "download" link
  * ssh to lintilla
    * cd to /opt/software/external/jenkins
    * rm -f jenkins.war.bak
    * mv jenkins.war jenkins.war.bak
    * wget "http://updates.jenkins-ci.org/download/war/new_release_number/jenkins.war
     ```bash
     Example: I just upgraded from 2.60.2 to 2.60.3
     cmd: wget "http://updates.jenkins-ci.org/download/war/2.60.3/jenkins.war
     ```
  * Go back to jenkins web server
    * Click on "Manage Jenkins" (you should see the option to upgrade automatically)
    * Click on "upgrade automatically" then follow instructions 
    
