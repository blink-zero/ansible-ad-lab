$import_users = Import-Csv -Path C:\ad_scripts\ad_import_users.csv
 
$import_users | ForEach-Object {
    New-ADUser `
        -Name $($_.FirstName + " " + $_.LastName) `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -Department $_.Department `
        -State $_.State `
        -EmployeeID $_.EmployeeID `
        -DisplayName $($_.FirstName + " " + $_.LastName) `
        -Office $_.Office `
        -UserPrincipalName $_.UserPrincipalName `
        -SamAccountName $_.SamAccountName `
        -AccountPassword $(ConvertTo-SecureString $_.Password -AsPlainText -Force) `
        -Enabled $True
}