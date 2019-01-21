Import-Module AzureRM.Compute
Import-Module AzureRM.Storage

Connect-MsolService 

$cred = Get-Credential
$tenantID = "9678040e-04e8-45ad-85f4-0343c4c48492"
$subscriptionName = "eNett-Corp-Subscription"
$ResourceGroupName = "Jubin"
$StorageAccountName = "WeeklyPowerShell"

& "C:\Users\jubin.lathif\Desktop\PwR\AzureCSV.ps1" `
-TenantId $tenantID -SubscriptionName $subscriptionName -Credential $cred

$ResourgroupValidation = & "C:\Users\jubin.lathif\Desktop\PwR\AzureCSV.ps1" -Name $ResourceGroupName

if(!($ResourgroupValidation)){
    New-AzureRmResourceGroup -Name $ResourceGroupName
}



$UserName = ""
$Password = ""
$SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

Connect-MsolService -Credential $Credential

$NewUser = New-MsolUser -UserPrincipalName "user@enett.com" -DisplayName “Test User” -FirstName “Test” -LastName “User”

Import-csv -Path "c:\Users\jubin.lathif\Desktop\PwR\" | foreach {New-MsolUser -DisplayName $_.DisplayName -firstname $_.firstname -lastname $_.lastname -UserPrincipalName $_.UserPrincipalName}