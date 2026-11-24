<# Creates the OU structure and security groups for TechCorp. Safe to re-run. #>
#Requires -Modules ActiveDirectory
$dn = (Get-ADDomain).DistinguishedName
foreach ($ou in 'IT','HR','Finance','Sales','Workstations','Service Accounts') {
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ou'" -SearchBase $dn -SearchScope OneLevel)) {
        New-ADOrganizationalUnit -Name $ou -Path $dn -ErrorAction Stop -ProtectedFromAccidentalDeletion $true
        Write-Host "Created OU: $ou"
    }
}
$groups = @{ HR_Group='HR'; Finance_Group='Finance'; IT_Admins='IT'; Helpdesk_Team='IT' }
foreach ($g in $groups.Keys) {
    if (-not (Get-ADGroup -Filter "Name -eq '$g'")) {
        New-ADGroup -Name $g -GroupScope Global -GroupCategory Security -Path "OU=$($groups[$g]),$dn"
        Write-Host "Created group: $g"
    }
}
Write-Host "Done. Add members with Add-ADGroupMember (see documentation/active-directory-configuration.md)."
