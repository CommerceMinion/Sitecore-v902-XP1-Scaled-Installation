
# Instructions for performing the Scaled deployment using Hyper-V

Add Hyper-V PS Module:
PS> Add-WindowsFeature RSAT-Hyper-V-Tools -IncludeAllSubFeature

Create a "Template" VM.  this will be copied for each of the separate role installs.
This takes a while to install and update but is faster than installing and updating each role server.

This will be a Windows Server 2016 VM downloaded from MSDN:
en_windows_server_2016_x64_dvd_9327751.iso (or later)
For production purposes you should use your own licensed servers.

Create a new VM and name it XC-XP1-Template
Install Windows Server 2016 and run through all the updates to get to the latest.
Default it to 2 virtual processors for better performance and attach it to an external network for easier downloading

Install other common requirements
Chrome
Turn off IE Enhanced Security (if allowed to by your org)

Export the VM to:
E:\SitecoreScaledDeployment\Exports

Import the exported Template to create a VM for SOLR.
Rename it to "xc-xp1-solr
Start the VM
Make a Checkpoint
Follow "01 Deploy_SOLR.md" instructions

Import the exported Template to create a VM for SQL.
Rename it to "xc-xp1-sql
Start the VM
Make a Checkpoint
Follow "01 Deploy_SQL.md" instructions

Import the exported template to create a base VVM for the various Sitecore roles
Rename it to "xc-xp1-base"
Start the VM
Make a Checkpoint
Install base dependencies
export vm
