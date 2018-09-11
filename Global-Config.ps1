Write-Host "Initializing Global Configuration ========== >>  $startDate" -ForegroundColor Gray ;

# Site Settings
$global:Prefix = "xp902"  #This is usually the name of the site
$global:ResourceRoot = "C:\resourcefiles"  #This is where the XP1 wdps have been unzipped to
$global:ConfigRoot = ".\config"  #Location of deployment configuration files
$global:PackageRoot = "$ResourceRoot\Sitecore 9.0.2 rev. 180604 (OnPrem)"
$global:LicenseFile = "$ResourceRoot\license.xml" #The Sitecore License.xml file

# SQL Server Settings
$global:SqlDbPrefix = $Prefix
$global:SqlAdminUser = "sa" 
$global:SqlAdminPassword="Test12345" 
$global:SqlServer = "XC-XP1-SQL"

#XConnect Settings
$global:XConnectEnvironment ="Development" #For production environment use Production
$global:XConnectLogLevel = "Information" #Can be Debug

$global:SqlCollectionUser = "collectionuser"
$global:SqlCollectionPassword = "Test12345"
$global:SqlProcessingPoolsUser = "poolsuser"
$global:SqlProcessingPoolsPassword = "Test12345"
$global:SqlProcessingTasksUser = "tasksuser"
$global:SqlProcessingTasksPassword = "Test12345"
$global:SqlMarketingAutomationUser = "marketingautomationuser"
$global:SqlMarketingAutomationPassword = "Test12345"
$global:SqlMessagingUser = "messaginguser"
$global:SqlMessagingPassword = "Test12345" 

$global:SqlReferenceDataUser = "referencedatauser"
$global:SqlReferenceDataPassword = "Test12345"

$global:SqlCoreUser = "coreuser"
$global:SqlCorePassword = "Test12345"
$global:SqlMasterUser = "masteruser"
$global:SqlMasterPassword = "Test12345"
$global:SqlWebUser = "webuser"
$global:SqlWebPassword = "Test12345"
$global:SqlReportingUser = "reportinguser"
$global:SqlReportingPassword = "Test12345"

$global:SqlFormsUser = "formsuser"
$global:SqlFormsPassword = "Test12345"
$global:SqlExmMasterUser = "exmmasteruser"
$global:SqlExmMasterPassword = "Test12345"

# SOLR
$global:SolrCorePrefix = $Prefix
$global:SolrUrl = "https://xc-xp1-solr:8983/solr" 

# Services
$global:ProcessingService = "https://$Prefix-xconnect"
$global:ReportingService = "https://$Prefix-xconnect"
$global:ReportingServiceApiKey = "abcde111112222233333444445555566"

$global:XConnectCollectionSearchService = "https://$Prefix-xconnect"
$global:XConnectReferenceDataService = "https://$Prefix-xconnect"

$global:MarketingAutomationOperationsService = "https://$Prefix-xconnect"
$global:MarketingAutomationReportingService = "https://$Prefix-xconnect"

$global:XConnectCollectionService = "https://$Prefix-xconnect"

# Encryption
$global:EXMCryptographicKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
$global:EXMAuthenticationKey = "0x0000000000000000000000000000000000000000000000000000000000000000"
$global:TelerikEncryptionKey = "PutYourCustomEncryptionKeyHereFrom32To256CharactersLong"

Write-Host "  Prefix >>  $Prefix" -ForegroundColor Gray ;
Write-Host "  ResourceRoot >>  $ResourceRoot" -ForegroundColor Gray ;
Write-Host "  ConfigRoot >>  $ConfigRoot" -ForegroundColor Gray ;
Write-Host "  PackageRoot >>  $PackageRoot" -ForegroundColor Gray ;
Write-Host "  LicenseFile >>  $LicenseFile" -ForegroundColor Gray ;

Write-Host "  SolrCorePrefix >>  $SolrCorePrefix" -ForegroundColor Gray ;
Write-Host "  SolrUrl >>  $SolrUrl" -ForegroundColor Gray ;

Write-Host "  EXMCryptographicKey >>  $EXMCryptographicKey" -ForegroundColor Gray ;
Write-Host "  EXMAuthenticationKey >>  $EXMAuthenticationKey" -ForegroundColor Gray ;
Write-Host "  TelerikEncryptionKey >>  $TelerikEncryptionKey" -ForegroundColor Gray ;

Write-Host "  ProcessingService >>  $ProcessingService" -ForegroundColor Gray ;
Write-Host "  ReportingService >>  $ReportingService" -ForegroundColor Gray ;
Write-Host "  ReportingServiceApiKey >>  $ReportingServiceApiKey" -ForegroundColor Gray ;
Write-Host "  XConnectCollectionSearchService >>  $XConnectCollectionSearchService" -ForegroundColor Gray ;
Write-Host "  XConnectReferenceDataService >>  $XConnectReferenceDataService" -ForegroundColor Gray ;
Write-Host "  MarketingAutomationOperationsService >>  $MarketingAutomationOperationsService" -ForegroundColor Gray ;
Write-Host "  MarketingAutomationReportingService >>  $MarketingAutomationReportingService" -ForegroundColor Gray ;

Write-Host "  XConnectCollectionService >>  $XConnectCollectionService" -ForegroundColor Gray ;

Write-Host "  SqlDbPrefix >>  $SqlDbPrefix" -ForegroundColor Gray ;
Write-Host "  SqlAdminUser >>  $SqlAdminUser" -ForegroundColor Gray ;
Write-Host "  SqlAdminPassword >>  $SqlAdminPassword" -ForegroundColor Gray ;
Write-Host "  SqlServer >>  $SqlServer" -ForegroundColor Gray ;

Write-Host "  SqlFormsUser >>  $SqlFormsUser" -ForegroundColor Gray ;
Write-Host "  SqlFormsPassword >>  $SqlFormsPassword" -ForegroundColor Gray ;
Write-Host "  SqlExmMasterUser >>  $SqlExmMasterUser" -ForegroundColor Gray ;
Write-Host "  SqlExmMasterPassword >>  $SqlExmMasterPassword" -ForegroundColor Gray ;

Write-Host "  XConnectEnvironment >>  $XConnectEnvironment" -ForegroundColor Gray ;
Write-Host "  XConnectLogLevel >>  $XConnectLogLevel" -ForegroundColor Gray ;
Write-Host "  SqlCollectionUser >>  $SqlCollectionUser" -ForegroundColor Gray ;
Write-Host "  SqlCollectionPassword >>  $SqlCollectionPassword" -ForegroundColor Gray ;
Write-Host "  SqlProcessingPoolsUser >>  $SqlProcessingPoolsUser" -ForegroundColor Gray ;
Write-Host "  SqlProcessingPoolsPassword >>  $SqlProcessingPoolsPassword" -ForegroundColor Gray ;
Write-Host "  SqlProcessingTasksUser >>  $SqlProcessingTasksUser" -ForegroundColor Gray ;
Write-Host "  SqlProcessingTasksPassword >>  $SqlProcessingTasksPassword" -ForegroundColor Gray ;
Write-Host "  SqlMarketingAutomationUser >>  $SqlMarketingAutomationUser" -ForegroundColor Gray ;
Write-Host "  SqlMarketingAutomationPassword >>  $SqlMarketingAutomationPassword" -ForegroundColor Gray ;
Write-Host "  SqlMessagingUser >>  $SqlMessagingUser" -ForegroundColor Gray ;
Write-Host "  SqlMessagingPassword >>  $SqlMessagingPassword" -ForegroundColor Gray ;

Write-Host "  SqlReferenceDataUser >>  $SqlReferenceDataUser" -ForegroundColor Gray ;
Write-Host "  SqlReferenceDataPassword >>  $SqlReferenceDataPassword" -ForegroundColor Gray ;

Write-Host "  SqlCoreUser >>  $SqlCoreUser" -ForegroundColor Gray ;
Write-Host "  SqlCorePassword >>  $SqlCorePassword" -ForegroundColor Gray ;
Write-Host "  SqlMasterUser >>  $SqlMasterUser" -ForegroundColor Gray ;
Write-Host "  SqlMasterPassword >>  $SqlMasterPassword" -ForegroundColor Gray ;
Write-Host "  SqlWebUser >>  $SqlWebUser" -ForegroundColor Gray ;
Write-Host "  SqlWebPassword >>  $SqlWebPassword" -ForegroundColor Gray ;
Write-Host "  SqlReportingUser >>  $SqlReportingUser" -ForegroundColor Gray ;
Write-Host "  SqlReportingPassword >>  $SqlReportingPassword" -ForegroundColor Gray ;
