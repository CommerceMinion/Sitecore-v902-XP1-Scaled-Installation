# Sitecore XP1 Scaled (On-Premise) Installation Notes

This is a guide or a reference for installing Sitecore XP1 v9.0 in a fully scaled on-premise environment.

>Note: This documentation is still a **work-in-progress**, do expect constant updates. For questions or need elaboration please send an email to *rasenieroAtGmailDotCom*.

## Getting Started

These instructions will serve as a guide or a reference for deploying Sitecore XP1 v9.0 in a fully scaled on-premise environment.

In the following scenario below, every core roles and XP service roles is performed by a dedicated server. This is a pre-built topology and is also known as XP1 Scaled. However, roles can be combine into a single instance, e.g. all xConnect and xDB roles (i.e. Collection, Collection Search, Marketing Automation, Marketing Automation Reporting, and ReferenceData) can be installed in a single instance. 

We will be referencing *the diagram* below in our instructions to come.

![fully-scaled-simple1](https://user-images.githubusercontent.com/2329372/42052718-721db50a-7ac4-11e8-8709-abb304179e2c.png)

## General Installation Approach

The general approach is to start with setting up *Solr* and a *Sql* instance then followed by *XConnect (i.e. Collection, CollectionSearch roles)*, *xDB Services (i.e. ReferenceData, MarketingAutomationReporting, MarketingAutomation roles)*, *Reporting*, *Processing*, *Content Management*, and *Content Delivery* instances.

Install and Configure SOLR:
DeploySolr\01 Deploy_SOLR.md

Install and Configure SQL:
02 Deploy_SQL.md
If you already have a SQL Server 2016 instance to use, then you should still validate the steps that ensure that SQL Server can be remotely installed to.  This includes having an admin username and password and ensuring the TCP/IP is enabled.

## Create Base VM

In order to expedite deployment, if you are using a virtualization technology, you can install all of the dependencies and do some basic configuration on a Base template and then export that template, to be reused in installing the various roles.  If you are not using virtualization and you are installing on physical machines then each of the steps for creating the Base VM must be done on each physical machine.
For the purposes of explaining the process, we are assuming you are using Hyper-V and any virtualization helper scripts assume Hyper-V, however you can use any virtualization system as long as you can create Windows VMs

## Prerequisites

Depending on the role or instance, each has it's own respective prerequisites, but the *general prerequisites* are enumerated below.

* Microsoft Windows Server 2016
* IIS 10 for Web server
* .NET Framework 4.6.2 or later
* PowerShell 5.1 or later
* Sitecore Installation Framework (SIF) PowerShell module
* Any Web Browsers in this list: Microsoft Internet Explorer 11, Mozilla Firefox, Google Chrome or Microsoft Edge
* Domain names for each roles i.e. search.mysite.com, searchcollection.mysite.com, reporting.mysite.com, processing.mysite.com

For the Hardware requirements, please refer to the Sitecore 9.0.2 Installation Guide. 

Configure PS
Open PS in Admin and change Execution Policy (Note: After install, set this back on production install):

```powershell
PS> Set-ExecutionPolicy unrestricted
```

----------------------------------------------------------
Install Chrome (dev install only)
https://www.google.com/chrome/

Install Visual Studio Code (dev install only)
https://code.visualstudio.com/download

Run VS Code and accept option to download Git
https://git-scm.com/download/win
Select to use Visual Studio Code as default editor
----------------------------------------------------------
Web Platform Installer (WPI) 5.0
https://www.microsoft.com/web/downloads/platform.aspx

Run Web Platform Installer:
Install following features using WPI 5.0:

* Web Deploy 3.6 for Hosting Servers
* URL Rewrite 2.1

As a side effect of installing these features is installation of over 50 prerequisite features and one of them is IIS

----------------------------------------------------------

### Add Windows Roles and Features

Even though you have already installed IIS and Web Deploy and URL Rewrite features, you still need to install a few more Windows Server features in order to run Sitecore properly.
Go to Server Manager to “Add Roles and Features”:

Navigate to “Server Roles” section:

Under “Web Server (IIS)” > “Web Server” > “Common HTTP Features” check these two values:

* HTTP Redirection
* WebDAV Publishing

Under “Application Development” check these values:

* .NET Extensibility 4.6
* ASP.NET 4.6

Now go to “Features” section and underneath check these two features:

* IIS Hostable Web Core
* Windows Identity Foundation 3.5

Proceed to install the roles/features

----------------------------------------------------------

Install asp.net 4.6.2 Framework (or latest 4.6.*) (Already installed on Windows Server 2016)
https://www.microsoft.com/en-us/download/details.aspx?id=53345

Other Dependencies
Microsoft Visual C++ 2015 redistributable (install both x86 and x64)
https://www.microsoft.com/en-us/download/details.aspx?id=53587

(may require restart)

Microsoft SQL Server Data-Tier Application Framework (DAC Fx) version 17.1 – Install both x64 and x86 version
https://www.microsoft.com/en-us/download/confirmation.aspx?id=55255
Note that both x86 and x64 have the same file name so download and install each one separately

SQLSysCLRTypes
http://go.microsoft.com/fwlink/?LinkID=849415&clcid=0x409

----------------------------------------------------------

Install SQL Server Powershell framework
https://docs.microsoft.com/en-us/sql/powershell/download-sql-server-ps-module?view=sql-server-2017

```powershell
Install-Module -Name SqlServer
```

Clone this repository into an *Installation Directory*.
    > Note: In this scenario the *Installation Directory* is c:\deploy_xp1_scaled, you can also use other location i.e. d:\deploy_xp1_scaled but you would need to update the scripts.

Install Sitecore Fundamentals and Sitecore Install Framework (SIF)
Open PS with Admin at location: C:\deploy_xp1_scaled

```powershell
PS> .\InstallSitecoreFundamentalsAndInstallFramework.ps1
```

Set NETWORK SERVICE with Modify permission to c:\inetpub\wwwroot folder

Set IIS_IUSRS or IUSR or NETWORK SERVICE with Modify permission to %WINDIR%\Temp\ folder
Set IIS_IUSRS or IUSR or NETWORK SERVICE with Modify permission to %WINDIR%\Globalization\ folder
Set IIS_IUSRS or IUSR or NETWORK SERVICE with Modify permission to %PROGRAMDATA%\Microsoft\Crypto\ folder

Clear the Web Platform Installer download cache

Download and extract *Sitecore 9.0.2 rev. 180604 (WDP XPScaled packages).zip* to the c:\resourcefiles directory.
    >https://dev.sitecore.net/~/media/F3BCFB785D0849EF857FFD1367797D21.ashx
    > Note: All  WDP Packages (*.zip files) should be directly under the c:\resourcefiles.
Save your Sitecore license file directly under this directory as *license.xml*.

In order to use deployment to install to a remote SQL Server instance, you need to install some additional dependencies

Install ODBC Driver 13.1 for SQL:
https://www.microsoft.com/en-us/download/details.aspx?id=53339

To execute remote commands to SQL, install the SQL Server Command Line Utility (sqlcmd):
https://www.microsoft.com/en-us/download/details.aspx?id=53591

Run command to manually register ScriptDom:

```powershell
.\GacMe -filePath "C:\Program Files (x86)\Microsoft SQL Server\140\DAC\bin\Microsoft.SqlServer.TransactSql.ScriptDom.dll"
```

Review the Configuration settings in Global-Config.ps1.  Your environment may require different settings.  These settings will be used for all role installs so it's important to get them right before exporting the VM as a Base template.

### At this point you should export this VM as a "base" VM which you can import and reuse for each instance install below

## Cleaning (starting over)

In some cases you may need to start over and start creating a topology from scratch.
You can reuse the existing SOLR and SQL VMs.
To expedite a clean restart, there is a script provided that can clean all the databases and users for a fresh start.
This only cleans the databases and does not clean any websites

```powershelll
.\Clean-Db
```

## xConnect and xDB Installation

There are six different roles to install for xConnect
xConnect.Collection
xConnect.Search
xDb.MarketingAutomation
xDB.MarketingAutomationReporting
xConnect.ReferenceData
ReportingInstance
ProcessingInstance

Note: It is possible to install each of these roles on an individual VM.  To simplify the instructions, the instructions show installing onto the same VM.  If you wish to install onto individual VMs then execute the following steps for each role.

### xConnect Collection Instance Installation

Import the exported VM and change its VM name and machine name to "SC-XC-Col"
Go into File Explorer/Network and ensure that file sharing is turned off and it is selected for Private Network so that it can find the SQL Server instance.

Open PS in admin in the c:\deploy_xp1_scaled directory

Since this is the first Sitecore specific VM, you need to create or acquire the cert for xconnect_client.
For dev and eval purposes, a self-signed cert can be created:

```powershell
.\xconnect-CreateCert.ps1
```

Since this same cert will be used on multiple machines, you should copy this cert off the Vm and have it handy to install on other machines.
It should end up in deployment directory:
SitecoreRootCert.crt
xp902.xconnect_client

To install the xConnect Collection role, edit the parameters for [xconnect-xp1-Collection.ps1](xconnect-xp1-Collection.ps1), they are exposed so its easy to change them for production environment purposes.

```powershell
.\xconnect-xp1-Collection.ps1
```

>Note: you can pass -Verbose or -WhatIf parameters to see more information or run the script without making actual changes.
>Note: The script will take about (+/-) 1 minute and 40 seconds to complete execution, see the [xconnect-xp1-collection.log](xconnect-xp1-collection.log) file.

### xConnect Collection Search Installation

To install the xConnect Collection Search role, edit the parameters for [xconnect-xp1-CollectionSearch.ps1](xconnect-xp1-CollectionSearch.ps1) script.

>Note: $SolrUrl and $SolrCorePrefix has been added.

```powershell
.\xconnect-xp1-CollectionSearch
```

>Note: The script will take about (+/-) 11 minutes to complete execution, 
see the [xconnect-xp1-collectionsearch.log](xconnect-xp1-collectionsearch.log) file

#### Expected Result

You should be able to see a new websites created on IIS with the name $SiteName
Issue: Script fails at last step trying to "ManageSchemas"   This is due to it not trusting the Self SSL used for Solr HTTPS
The error should not be harmful since the cores were already installed in the previous step where SOLR was set up.

### xDb Marketing Automation Installation

To install xDB Marketing Automation role, edit [xconnect-xp1-MarketingAutomation.ps1](xconnect-xp1-MarketingAutomation.ps1) scripts to reflect local settings.

```powershell
.\xconnect-xp1-MarketingAutomation
```

Note: If the script fails on the first run and you need to rerun it, perform an iisreset in the terminal.

```powershell
PS C:\> iisreset
```

Note: The script will take about (+/-) 9 seconds to complete execution, see the [xconnect-xp1-MarketingAutomation.log](xconnect-xp1-MarketingAutomation.log) file.

### xDB Marketing Automation Reporting Installation

To install xDB Marketing Automation Reporting role, edit the [xconnect-xp1-MarketingAutomationReporting.ps1](xconnect-xp1-MarketingAutomationReporting.ps1) scripts to reflect local settings.

```powershell
.\xconnect-xp1-MarketingAutomationReporting
```

>Note: The script will take about (+/-) 6 seconds to complete execution, see the [xconnect-xp1-MarketingAutomationReporting.log](xconnect-xp1-MarketingAutomationReporting.log) file.

Note: If you need to rerun the script, perform a iisreset on the terminal, see below.

```powershell
PS C:\>iisreset
```

### xDb Reference Data Installation

To install xDB Reference Data role, edit the parameters of [xconnect-xp1-ReferenceData.ps1](xconnect-xp1-ReferenceData.ps1) scripts to reflect local settings.

```powershell
.\xconnect-xp1-ReferenceData
```

>Note: The script will take about (+/-) 29 seconds to complete execution, see the [xconnect-xp1-ReferenceData.log](xconnect-xp1-ReferenceData.log) file.

## Sitecore Processing Installation

### Reporting Instance Installation

To install Reporting role, edit the parameters in the [sitecore-xp1-Reporting.ps1](sitecore-xp1-Reporting.ps1) scripts to reflect local settings.

```powershell
.\sitecore-xp1-Reporting.ps1
```

>Note: The script will take about (+/-) 13 seconds to complete execution, see the [sitecore-XP1-rep.log](sitecore-XP1-rep.log) file.

### Processing Instance Installation

To install Processing role, edit the parameters in the [sitecore-xp1-Processing.ps1](sitecore-xp1-Processing.ps1) script.

```powershell
.\sitecore-xp1-Processing.ps1
```

>Note: The script will take about (+/-) 38 seconds to complete execution, see the [sitecore-XP1-prc.log](sitecore-XP1-prc.log) file.

## Sitecore Roles Installation

### Content Management Instance Installation

Copy the base VM and rename it as xp902-cm

Install SitecoreRootCert into trusted root
Install the previously created xp902.xconnect_client.crt certficate into Cert:\Localmachine\My (trusted root) using CertMgr
Copy to LocalMachine/My as well
Needed to go back and export again with secret

To install Content Management role, edit the parameters in the [sitecore-xp1-ContentManagement.ps1](sitecore-xp1-ContentManagement.ps1) scripts to reflect local settings.

```powershell
.\sitecore-xp1-ContentManagement
```

>Note: The script will take about (+/-) 3 minute 46 seconds to complete execution, see the [sitecore-XP1-cm.log](sitecore-XP1-cm.log) file.

After a successful deployment, ensure Sitecore is up and running:
https://xp902.cm/sitecore

Here are some basic activities to ensure Sitecore is up and functioning correctly:
Rebuild Link Databases
Go into Control Panel and, in the Database area, select "Rebuild link databases"
Select them all and push the "Rebuild" button

Rebuild indexes
Go into Control Pane and, in the Indexing area, select "Indexing Manager"
Select all the indexes and click the "Rebuild" button

### Content Delivery Instance Installation

Copy the base VM and rename it as xp902-cd

Install SitecoreRootCert into trusted root
Install the previously created xp902.xconnect_client.crt certficate into Cert:\Localmachine\Root using CertMgr
Copy to LocalMachine/My as well

To install Content Delivery role, edit the parameters in [sitecore-xp1-ContentDelivery.ps1](sitecore-xp1-ContentDelivery.ps1) script.

```powershell
.\sitecore-xp1-ContentDelivery.ps1
```

>Note: The script will take about (+/-) 6 seconds to complete execution, see the [sitecore-XP1-cd.log](sitecore-XP1-cd.log) file.

## Built With

* [Sitecore 9.0 Update 2](http://www.sitecore.come) - The Sitecore XP1 Scaled Platform

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Ramon Aseniero** - *Initial work* - [Sitecore](https://github.com/raseniero)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
