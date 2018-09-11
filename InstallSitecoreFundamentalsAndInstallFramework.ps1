Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2 -InstallationPolicy Trusted
Install-Module -Name SitecoreFundamentals -Repository SitecoreGallery -MaximumVersion 1.1.0
Install-Module -Name SitecoreInstallFramework -Repository SitecoreGallery -MaximumVersion 1.2.1
