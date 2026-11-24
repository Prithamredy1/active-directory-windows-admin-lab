<# Creates department folders with least-privilege NTFS + share permissions. Run on DC01 after create-groups.ps1. #>
#Requires -Modules SmbShare, ActiveDirectory
$netbios = (Get-ADDomain).NetBIOSName
foreach ($dept in 'HR','Finance','IT') {
    $path = "C:\CompanyData\$dept"
    $group = if ($dept -eq 'IT') { 'IT_Admins' } else { "${dept}_Group" }
    New-Item $path -ItemType Directory -Force | Out-Null
    icacls $path /inheritance:r | Out-Null
    icacls $path /grant "SYSTEM:(OI)(CI)F" "BUILTIN\Administrators:(OI)(CI)F" "${netbios}\${group}:(OI)(CI)M" | Out-Null
    if (-not (Get-SmbShare -Name $dept -ErrorAction SilentlyContinue)) { New-SmbShare -Name $dept -Path $path -ChangeAccess "${netbios}\${group}" | Out-Null }
    Write-Host "$dept share ready for $group"
}
