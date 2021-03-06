# Jenkins

Base directory to store Jenkins downloads scripts and config files

```
Jenkins is an open source automation server written in Java. 
Jenkins helps to automate the non-human part of software development process, 
with continuous integration and facilitating technical aspects of continuous delivery
```

## What do we download from Jenkins -- http://mirrors.jenkins-ci.org/war-stable/latest/?

We download the ``` jenkins.war ``` file of the latest stable release verion

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
  * Log on to Jenkins web server : http://jenkins.mdibl.org
  * Click on "Manage Jenkins" 
  * if there is a new release suggestion then 
    * ssh to jenkins server to user "bioadmin" home directory
    * cd to /home/bioadmin/package_downloads
    * run ``` ./download_package jenkins/jenkins.cfg ```
  * Go back to jenkins web server
    * Click on "Manage Jenkins" (you should see the option to upgrade automatically)
    * Click on "upgrade automatically" then follow instructions 
    
