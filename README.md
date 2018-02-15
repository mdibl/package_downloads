# Biocore Package Downloads Repos

A repository to create automations that download and Install external bioinformatics packages. For each installed package, this tool can be setup to run an automation that checks if a new version of the tool is available. As soon as it detects a new release of the tool, the automation will download and install it locally.

## What It Does

For each package installed,the automation creates a root directory that is the name of the tool in the path set in the main Configuration (EXTERNAL_SOFTWARE_BASE).

Under the tool root directory, you will find:

A file (current_release_NUMBER) that stores the latest version of this tool
A directory for each version of this tool installed
A symbolic with this tool name that points to the latest version installed

Check [[Package Documentation]]
