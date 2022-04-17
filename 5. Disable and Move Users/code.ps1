#Import CSV
$users = Import-Csv C:\Users\Administrator\Desktop\Names.csv
#Disabled users OU
$OU = "OU=Desabilitados,OU=Recife,OU=BR,OU=company,DC=serverdomain,DC=local"

foreach($user in $users){
    #Case 1: Disabled User that are not in the right OU
    if(Get-ADUser  -Identity $user.samaccountname -Properties * |Where-Object {($_.Enabled -eq $False) -and ($_.DistinguishedName -notmatch $OU)}){
        
        Write-Host "User"$user.samaccountname"is DISABLED but Not in the right OU" -BackgroundColor White -ForegroundColor DarkRed
        Write-Host "Moving User" $user.samaccountname -BackgroundColor black -ForegroundColor White
        Get-ADUser -Identity $user.samaccountname -Properties * |Move-ADObject -TargetPath $OU
        Write-Host "User"$user.samaccountname"OU:"$OU
    
    }

    #Case 2: User is Enabled
    if(Get-ADUser -Identity $user.samaccountname -Properties * |Where-Object {($_.Enabled -eq $TRUE)}){

        Write-Host "User"$user.samaccountname"is ENABLED" -BackgroundColor white -ForegroundColor DarkRed
        Write-Host "Disabling"$user.samaccountname"and moving to"$OU -BackgroundColor Black -ForegroundColor White
        Get-ADUser -Identity $user.samaccountname -Properties * |Set-ADUser -Enabled $False
        Get-ADUser -Identity $user.samaccountname -Properties * |Move-ADObject -TargetPath $OU
    
    }

    #Case 3: User is Disabled and in the right OU, no action is required here. This part is just a validation!!
    if(Get-ADUser -Identity $user.samaccountname -Properties *|Where-Object {($_.Enabled -eq $FALSE) -and ($_.DistinguishedName -match $OU)}){
    
        Write-Host "User"$user.samaccountname"is DISABLED and in the RIGHT OU" -BackgroundColor Black -ForegroundColor White

    }
}