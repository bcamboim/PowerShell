echo "`n"|Out-Null
Write-Host "FILE CONTAINING THE NAME OF THE GROUPS HAS TO BE .TXT" -BackgroundColor White -ForegroundColor DarkRed
echo "`n"|Out-Null 
Start-Sleep -Seconds 3
#OPEN FILE DIALOG
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$dialogo = New-Object System.Windows.Forms.OpenFileDialog
$dialogo.InitialDirectory = "c:\"
$dialogo.Filter = "TXT (*.txt) |*.txt" 

$pathArquivo

if($dialogo.ShowDialog() -eq "Cancel"){
    #SHUTS DOWN THE SCRIPT IF THE USER CLICKS ON THE "CANCEL" BUTTON
    echo "`n"
    Write-Warning "NO FILE WAS CHOSEN"
    Break
}else{
    #ATTRIBUTES THE PATH OF THE ARCHIVE TO A VARIABLE
    $pathArquivo = $dialogo.FileName 
}
#IMPORTS THE TXT FILE THAT CONTAINS THE NAME OF THE GROUPS THAT YOU WANT TO GET THE MEMBERS OF
$arqTxt = Get-Content $pathArquivo

Write-Host "`nIMPORTING TXT" -ForegroundColor DarkRed -BackgroundColor White
Start-Sleep -Seconds 3
#ATTRIBUTES EVERY LINE OF THE TXT FILE (GROUP) TO AN INDEX ON AN ARRAY
$arrayGrupo = @()
foreach($linha in $arqTxt){
    $arrayGrupo += $linha
}

$arrayGrupoInexistente = @() #THIS ARRAY WAS CREATED TO STORE EVERY GROUP THAT WAS NOT FOUND ON ADDS

#HERE IS WHERE YOU GO THROUGH YOUR ARRAY OF GROUPS AND GET EVERY MEMBER WITHIN THE GROUPS
$resultadoExtracao = foreach($grupo in $arrayGrupo){
    if(Get-ADGroup -Filter {name -eq $grupo}){
       #GET THE MEMBER OF THE GROUPS AND ORGANIZE THE RESULTS BY samaccountname, name, GroupName AND Description
        Get-ADGroupMember $grupo |select samaccountname, name, @{n='GroupName';e={$grupo}}, @{n='Description';e={(Get-ADGroup $grupo -Properties description).description}}

    }else{
        #IF THE GROUP IS NOT FOUND, SHOW THE USER A MESSAGE AND ADD IT TO THE ARRAY OF GROUPS THAT DOES NOT EXIST ON ADDS
        Write-Warning "THE GROUP $grupo DOES NOT EXIST ON ADDS"
        $arrayGrupoInexistente += $grupo
        } 
    }


echo "`n" |Out-Null
#ASK THE USER IF HE/SHE WANTS TO STORE THE GROUPS THAT DOES NOT EXIST ON A TXT FILE
$PrintGrupoInexistente = (Read-Host "``nDO YOU WANT TO EXPORT THE NONEXISTENT GROUPS TO A TXT FILE?[y/n]").ToLower() 

echo "`n"|Out-Null
#IF THE ANSWER IS YES 
if($PrintGrupoInexistente -eq "y"){
    #SAVE FILE DIALOG
    $dlg = New-Object System.Windows.Forms.SaveFileDialog
    $dlg.InitialDirectory = "c:\"
    $dlg.FileName = "Document"
    $dlg.DefaultExt = ".txt"
    $dlg.Filter = "Text documents (.txt)|*.txt"

    $result = $dlg.ShowDialog()

    if ($result) {
        
       $filename = $dlg.FileName #VARIABLE THAT STORES THE PATH OF THE SAVE FILE
 
    }
    
    $arrayGrupoInexistente | Out-File $filename #EXPORTS THE TXT FILE
    Write-Host "`nEXPORTING THE NONEXISTENT GROUPS TO A TXT FILE" -ForegroundColor DarkRed -BackgroundColor White
    Start-Sleep -Seconds 3
       
}

#EXPO
Write-Host "`nEXPORTING GROUP MEMBERS OF THE GROUPS THAT WERE FOUND ON ADDS" -ForegroundColor DarkRed -BackgroundColor White
Start-Sleep -Seconds 3 |Out-Null
#SAVE FILE DIALOG THAT HAS AS FILTER CSV FILES
$dlgExtr = New-Object System.Windows.Forms.SaveFileDialog
$dlgExtr.InitialDirectory = "c:\"
$dlgExtr.FileName = "GroupMembers"
$dlgExtr.DefaultExt = ".csv"
$dlgExtr.Filter = "CSV FiLe (.csv)|*.csv"

$resultExtr = $dlgExtr.ShowDialog()

if($resultadoExtracao){
    $filenameExtr = $dlgExtr.FileName
}

$resultadoExtracao | Export-Csv $filenameExtr #EXPORTING THE GROUP MEMBER AS A CSV FILE

Write-Host "`nSUCCESSFULLY COMPLETED" -ForegroundColor DarkRed -BackgroundColor White
Start-Sleep -Seconds 3 |Out-Null

Read-Host -Prompt "`nPRESS ENTER TO FINISH" 