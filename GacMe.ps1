Param(
   [string]$filePath
)

    $ErrorActionPreference = "Stop"

    if ( $null -eq ([AppDomain]::CurrentDomain.GetAssemblies() |? { $_.FullName -eq "System.EnterpriseServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" }) ) {   
        [System.Reflection.Assembly]::Load("System.EnterpriseServices, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a") | Out-Null   
    }   
                 
    $publish = New-Object System.EnterpriseServices.Internal.Publish   
 
    $assembly = $null  
                  
    Write-Output "Evaluating File: $($filePath)"

    if ( $filePath -is [string] ) {  
        $assembly = $filePath  
    }
    elseif ( $filePath -is [System.IO.FileInfo] ) {  
        $assembly = $_.FullName  
    }
    else {  
        throw ("The object type '{0}' is not supported." -f $filePath.GetType().FullName)  
    }  
                                
    if ( -not (Test-Path $assembly -type Leaf) ) {  
        throw "The assembly '$assembly' does not exist."  
    }  
                                    
    if ( [System.Reflection.Assembly]::LoadFile( $assembly ).GetName().GetPublicKey().Length -eq 0 ) {  
        throw "The assembly '$assembly' must be strongly signed."  
    }  
                                        
    Write-Output "Installing: $assembly"  
                                            
    $publish.GacInstall( $assembly ) 
