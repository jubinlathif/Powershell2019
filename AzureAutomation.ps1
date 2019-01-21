#----------------Create new folder "AzureAumation"----------------#
#--------method 1----------# 
New-Item C:\users\jubin.lathif\Desktop\GeminiTraining2019\pwr\AzureAumation -ItemType directory


#--------method 2----------#
md C:\users\jubin.lathif\Desktop\GeminiTraining2019\pwr\AzureAumation


#--------method 3----------#
[system.io.directory]::CreateDirectory("C:\users\jubin.lathif\Desktop\GeminiTraining2019\pwr\AzureAumation")


#--------method 4----------#
$fso = new-object -ComObject scripting.filesystemobject

$fso.CreateFolder("C:\users\jubin.lathif\Desktop\GeminiTraining2019\pwr\AzureAumation")


#---------------Check if azurerm module is installed on current user node----------------------------------#
get-module azurerm -ListAvailable


#----------------Check latest version of azurerm available--------------#
find-module azurerm


#----------------install latest version of azurerm available------------#
install-module azurerm -Scope CurrentUser -Force


#----------------login and logout to Azure via PS----------------------------------#
Login-AzureRmAccount

Logout-AzureRmAccount


#----------------show details of avalaible azure tenants----------------------------------#
get-azurermtenants

#----------------select azure subscription----------------------------------#
Select-AzureRmSubscription -Subscription 'Infra.Dev.eNett'


#----------------create new azure resource group----------------------------------#
New-AzureRmResourceGroup -name 'automationJubin-ps-rg' -location australiasoutheast











