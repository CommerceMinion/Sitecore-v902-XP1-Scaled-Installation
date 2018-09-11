# Sitecore XP1 Scaled (On-Premise) Installation Notes

This is a guide or a reference for installing Sitecore XP1 v9.0 in a fully scaled on-premise environment.

>Note: This documentation is still a **work-in-progress**, do expect constant updates. For questions or need elaboration please send an email to *rasenieroAtGmailDotCom*.

## Getting Started

These instructions will serve as a guide or a reference for deploying Sitecore XP1 v9.0 in a fully scaled on-premise environment. 

In the following scenario below, every core roles and XP service roles is performed by a dedicated server. This is a pre-built topology and is also known as XP1 Scaled. However, roles can be combine into a single instance, e.g. all xConnect and xDB roles (i.e. Collection, Collection Search, Marketing Automation, Marketing Automation Reporting, and ReferenceData) can be installed in a single instance. 

We will be referencing *the diagram* below in our instructions to come.

![fully-scaled-simple1](https://user-images.githubusercontent.com/2329372/42052718-721db50a-7ac4-11e8-8709-abb304179e2c.png)

## Prerequisites

* Solr 6.6.2
* Chocolatey 0.10.11
* Java/JRE 1.8 (installed using Chocolatey)
* NSSM 2.24 (installed using Chocolatey)
* OpenSSL.Light 1.1.0 (installed using Chocolatey)

To setup *Solr* instance see section [Installation->Solr Instance](README.md#solr-instance-installation)

### Solr Instance Installation

1. Install Chocolatey by runnning the PowerShell script below as Administrator.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

2. Install NSSM using Chssocolatey by running the command below.

```powershell
C:\> choco install nssm
```

3. Install JRE 1.8 using Chocolatey by running the command below.

```powershell
C:\> choco install jre8
```

4. Install OpenSSL using Chocolatey by running the command below.

```powershell
C:\> choco install openssl.light
```

5. Download and install Solr 6.2.2 by following the [Installing Solr](https://lucene.apache.org/solr/guide/6_6/installing-solr.html) guide.
6. Enable SSL on Solr by following the [Enabling SSL](https://lucene.apache.org/solr/guide/6_6/enabling-ssl.html) guide.

Create SSL Keys for SOLR:
Open PowerShell command prompt. Do not use Powershell ISE, it won’t work with it!
PS> .\SolrSSL.ps1
KeyTool Path: C:\Program Files\Java\jre1.8.0_181\bin\keytool.exe
Move generated key files from c:\resourcefiles to C:\Solr\solr-6.6.2\server\etc
solr-ssl-keystore.p12
solr-ssl.keystore.jks

7. Setup as a Service using NSSM
C:\ProgramData\chocolatey\lib\NSSM\tools

Run Command:
nssm install Solr
This will open a dialog, populate Application as such:
 
Note the non-standard port.  This will be using SSL so the non-standard port indicates it is different than the default.
Path: C:\Solr\solr-6.6.2\bin\solr.cmd
Startup Directory: C:\Solr\solr-6.6.2\bin
Arguments: 

Switch to Details and populate as such:
Display Name: Solr 6.6.2
Description: Solr port 8983 (ssl)
Open “Services” on Windows Server and verify that you have Solr service in list of services:

Copy core configurations from:
DeploySolr\SolrCores
To:
C:\Solr\solr-6.6.2\server\solr

Start the service

Open Chrome and navigate to https://localhost:8983/solr/ :
Validate that the cores are present

Open up port 8983 in the Firewall

Validate that Solr can be accessed by an external machine:
https://xc-xp1-solr:8983/solr



---------------------------------------
Alternately you can install the cores using the PS script:
8. To install the Sitecore Solr Cores, edit the parameters on the [c:\deploy_xp1_scaled\sitecore-SolrCores.ps1](sitecore-SolrCores.ps1) scripts to match local values.

```powershell
#define parameters
$Prefix = "xp901"
$PSScriptRoot = "c:\deploy_xp1_scaled"
$Path = "$PSScriptRoot\config\sitecore-solr.json"

$SolrUrl = "https://localhost:8983/solr"
$SolrRoot = "C:\solr-6.6.2"
$SolrService = "solr662"
$CorePrefix = $Prefix
```

9. Run c:\deploy_xp1_scaled\sitecore-SolrCores.ps1 <<Press Enter>>

```powershell
PS C:\> .\sitecore-SolrCores.ps1 scripts
```

>Note: If the cores exist, they will be overwritten.
10. To install the xConnect Solr Cores, edit the parameters on the [c:\deploy_xp1_scaled\xconnect-SolrCores.ps1](xconnect-SolrCores.ps1) scripts to match local values.

```powershell
#define parameters
$Prefix = "xp901"
$PSScriptRoot = "c:\deploy_xp1_scaled"
$ConfigPath = "$PSScriptRoot\config"

$SolrUrl = "https://localhost:8983/solr"
$SolrRoot = "C:\solr-6.6.2"
$SolrService = "solr662"
```

11. Run c:\deploy_xp1_scaled\xconnect-SolrCores.ps1 scripts.

```powershell
PS C:\> .\xconnect-SolrCores.ps1 <<Press Enter>>
```

>Note: If the cores exist, they will be overwritten.
  
#### Expected Result

You should be able to browse the Solr website using the $SolrUrl i.e. opening the https://localhost:8983/solr in your browser.
