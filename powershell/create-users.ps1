<# Creates users from users.csv in the OU matching their department.
   The initial password is typed at run time - never stored in the script or in GitHub. #>
#Requires -Modules ActiveDirectory
param([string]$CsvPath = "$PSScriptRoot\users.csv")
. "$PSScriptRoot\common.ps1"
$domain = Get-ADDomain
$pw = Read-Host "Initial password for new users" -AsSecureString
Import-Csv $CsvPath | ForEach-Object {
    if (Get-ADUser -Filter "SamAccountName -eq '$($_.Username)'") { Write-Warning "$($_.Username) already exists - skipped"; return }
    New-ADUser -Name "$($_.FirstName) $($_.LastName)" -GivenName $_.FirstName -Surname $_.LastName `
        -SamAccountName $_.Username -UserPrincipalName "$($_.Username)@$($domain.DNSRoot)" `
        -Department $_.Department -Path "OU=$($_.Department),$($domain.DistinguishedName)" `
        -AccountPassword $pw -Enabled $true -ChangePasswordAtLogon $true
    Write-AdminLog 'CREATE_USER' $_.Username
    Write-Host "Created $($_.Username) in OU $($_.Department)"
}
