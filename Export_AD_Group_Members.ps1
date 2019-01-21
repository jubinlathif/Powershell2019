Import-Module ActiveDirectory
Get-ADGroupMember -identity “jira-users” | select name | Export-csv -path C:\Users\deon.grobler\Documents\Work\AD_Groups\Groupmembers.csv -NoTypeInformation
Import-module
Install-Module -Name MicrosoftTeams -RequiredVersion 0.9.0 
get-team