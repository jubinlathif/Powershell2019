#-----------------creating a runbook----------------------------#
new-azurermautomationrunbook    #--------fill in the parameters-----------#


#--------Adding code to new Runbook-----------#
Import-AzureRmAutomationRunbook   #--------fill in the parameters------ use force if required-----#

$rg = 'automationJubin-ps-rg'

$aa = 'AutomationJubinTestVM-ps-aa'

New-AzureRmAutomationRunbook -Name 'First-runbookJubin-PS' -Description 'first runbook through PS' -Type PowerShell -ResourceGroupName $rg -AutomationAccountName $aa

Import-AzureRmAutomationRunbook -Path 'C:\Users\jubin.lathif\Desktop\GeminiTraining2019\PwR\AzureAumation\first-runbook-ps.ps1' -Name 'First-runbookJubin-PS' -Type PowerShell -ResourceGroupName $rg -AutomationAccountName $aa -Force


#--------Automation-assets-----------#
Get-Command -Module azurerm new-azurernautomation*


New-AzureRmAutomationVariable -Name 'log-age2' -Encrypted $false -Description 'max number of days old a log file can be' -Value 2 -AutomationAccountName $aa -ResourceGroupName $rg


$securestring = 'password' | convertto-securestring -AsPlainText -force

$credential = [pscredential]::new('vm-admin',$securestring)


New-AzureRmAutomationCredential -Name 'login-creds2' -Description 'Credentials for loggin into our VM' -Value $credential -ResourceGroupName $rg -AutomationAccountName $aa


#-----------------------testing and developing a Runbook-----------------------------------#

































