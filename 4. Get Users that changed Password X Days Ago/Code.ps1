$Tempo=(Get-Date) - (New-TimeSpan -Days 2)
$a= Get-AdUser -Filter * -Properties *| Where-Object {$_.PasswordLastSet -gt $Tempo } | 
Select-Object -Property SamAccountName, DisplayName, PasswordLastSet|
Export-Csv C:\Users\plima_ava_ext\Documents\User_PWD2Days.csv -NoTypeInformation