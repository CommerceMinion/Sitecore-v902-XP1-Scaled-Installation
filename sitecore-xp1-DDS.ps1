#define parameters 
$Prefix = "xp" 
$PSScriptRoot = "c:\deploy_xp1_scaled"
$ConfigPath = "$PSScriptRoot\config"

$XConnectCollectionService = "$Prefix.xconnect" 
$SitecoreSiteName = "$Prefix.sc"

$SolrUrl = "https://localhost:8983/solr" 
$SolrRoot = "C:\solr-6.6.2" 
$SolrService = "solr662" 

$SqlServer = "RAMONASENIE0E1F" 
$SqlAdminUser = "sa" 
$SqlAdminPassword="jajnav5@" 
  
#install sitecore instance 
$XconnectHostName = "$Prefix.xconnect" 
$SitecoreParams = @{     
    Path = "$ConfigPath\xconnect-XP1-dds.json"     
    Package = "$PSScriptRoot\Sitecore 9.0.2 rev. 180604 (OnPrem)_dds.scwdp.zip"     
    LicenseFile = "$PSScriptRoot\license.xml"     
    SqlDbPrefix = $Prefix  
    SqlServer = $SqlServer  
    SqlAdminUser = $SqlAdminUser     
    SqlAdminPassword = $SqlAdminPassword     
    SolrCorePrefix = $Prefix  
    SolrUrl = $SolrUrl     
    XConnectCert = $certParams.CertificateName     
    Sitename = $SitecoreSiteName         
    XConnectCollectionService = "https://$XConnectCollectionService"    
} 
Write-Host @SitecoreParams
Install-SitecoreConfiguration @SitecoreParams 