#PowerShell
$dcs = Get-ADDomainController

$id = read-host "Event ID [4624/4625]" #reads input as a string
$id = $id -as [int] #convert string to int

if (($id -eq 4625) -or ($id -eq 4624)){ #here we are only interested in these to types of ID

    $user = (Read-Host "UserName").ToLower()
    $searchPeriod = read-host "Search period [days]"
    $searchPeriod = $searchPeriod -as [int]

    foreach ($dc in $dcs) {
        $events = Get-WinEvent -ComputerName $dc.HostName -FilterHashtable @{
            logname = 'security'
            id= $id
            data=$user
            starttime = (Get-Date) - (New-TimeSpan -Days $searchPeriod) 
        } | Select-Object -Property timecreated, ID, 
            @{label='Username';expression={$_.properties[5].value}},
            @{label='IP';expression={$_.properties[18].value}},
            @{label='WorkStation';expression={$_.properties[11].value}}

        $events

        $export = (read-host "Export Logs [y/n]").ToLower()
        if ($export -eq 'y') {
            #Save dialogue
            [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
            $dlg = New-Object System.windows.forms.SaveFileDialog
            $dlg.InitialDirectory = "c:\"
            $dlg.FileName = "UserLog"
            $dlg.DefaultExt = ".csv"
            $dlg.Filter = "CSV (.csv)|*.csv"

            if($dlg.ShowDialog() -eq 'Cancel'){
                Write-Host "No path was chosen, the operation will be terminated" -BackgroundColor White -ForegroundColor DarkRed
                break
                
            }else{
                $path = $dlg.FileName
            }
            $events | Export-Csv $path -notypeinformation
        }
    }
 
} else{
    Write-Host "Invalid ID" -BackgroundColor White -ForegroundColor DarkRed
}
