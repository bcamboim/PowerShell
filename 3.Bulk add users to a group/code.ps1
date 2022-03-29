Import-Module ActiveDirectory
#open file dialogue
[System.Reflection.Assembly]::LoadWithPartialName("system.windows.form")|Out-Null
$dlg = New-Object System.Windows.Forms.OpenFileDialog
$dlg.InitialDirectory = "C:\Users\Administrator\Desktop"
$dlg.Filter = "CSV (.csv)|*.csv"
$open = $True
if ($open) {
    if ($dlg.showdialog() -eq "Cancel") {
        Write-Host "No file was picked" -ForegroundColor Yellow -BackgroundColor Black
        break
    }else {
        $filePath = $dlg.filename 
    }    
}

$users = import-csv $filePath -Delimiter ";"

$group = "SC-IT_BR"
#Get the already existing members of the group
Get-ADGroupMember -Identity $group | Select-Object -Property SamAccountName | Export-Csv C:\Users\Expor.csv -NoTypeInformation
$importMembers = Import-Csv C:\Users\Expor.csv

foreach ($member in $importMembers) {
    foreach($user in $users){
        #Compare the users that are in the group with the users that you want to add to the group
        if($user.Username -eq $member.SamAccountName){
            Write-Host $user.Username "Already is in" $group -ForegroundColor Yellow -BackgroundColor Black
        }else{
            #Add the users to the group
            Add-ADGroupMember -Identity $group -Members $user.username
        }
    }   
}