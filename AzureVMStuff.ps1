Import-Module AzureRM.Compute
Import-Module AzureRM.Storage



$cred = Get-Credential
$tenantID = "9678040e-04e8-45ad-85f4-0343c4c48492"
$subscriptionName = "eNett-Corp-Subscription"
$ResourceGroupName = "InfraPSChallengeJack"
$StorageAccountName = "infrapschallenge"

& "C:\Users\jack.crawford\Documents\PSChallenge\New-AzureConnection.ps1" `
-TenantId $tenantID -SubscriptionName $subscriptionName -Credential $cred

$ResourgroupValidation = & "C:\Users\jack.crawford\Documents\PSChallenge\Validate-ResourceGroup.ps1" -Name $ResourceGroupName

if(!($ResourgroupValidation)){
    New-AzureRmResourceGroup -Name $ResourceGroupName
}



# Define a credential object
$vmname = Invoke-Expression -Command "C:\Users\jack.crawford\Documents\PSChallenge\Get-VacantHostname.ps1"
Write-Host "Using $vmname"
$location = "australiasoutheast"

Write-Host "Determine your local admin credentials for the new server"
$localAdmin = Get-Credential

Write-Host "Enter domain credentials to add the VM to the domain"
$domainCred = Get-Credential

& "C:\Users\jack.crawford\Documents\PSChallenge\Create-AzureRMVM.ps1" -vmname $vmname -location $location -ResourceGroup $ResourceGroupName -Credential $localAdmin

#Add to Domain

$domainCred = Get-Credential
$DomainName = "enett.local"
$Settings = @{
            "Name" = "$DomainName";
            "User" = $domainCred.UserName;
            "Restart" = "true";
            "Options" = 3;
        }
$ProtectedSettings =  @{
                "Password" = $domainCred.GetNetworkCredential().Password
        }

Set-AzureRmVMExtension -ResourceGroupName InfraPSChallengeJack -ExtensionType "JsonADDomainExtension"`
-Name "JoinAD" -Publisher "Microsoft.Compute" -TypeHandlerVersion "1.3"`
-VMName $vmname -Location australiasoutheast -SettingString $Settings -ProtectedSettingString $ProtectedSettings

<# Install IIS
. "C:\Users\jack.crawford\Documents\PSChallenge\Invoke-AzureRmVmScript.ps1"
    $params = @{
        ResourceGroupName = $ResourceGroupName
        VMName = $vmname
        StorageAccountName = $StorageAccountName
        StorageAccountKey = $StorageAccountKey
        Force = $True
    }
    
    Invoke-AzureRmVmScript @params -ScriptBlock {
        Add-WindowsFeature Web-Server
        #https://technet.microsoft.com/en-us/library/ee790599.aspx
        New-WebBinding -Name "Default Web Site" -IP "*" -Port 443 -Protocol https
        #https://docs.microsoft.com/en-us/iis/manage/powershell/powershell-snap-in-configuring-ssl-with-the-iis-powershell-snap-in

    }
    #>