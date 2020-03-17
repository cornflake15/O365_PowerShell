
Function Get-FileName($initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
    Out-Null 

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
    $OpenFileDialog.initialDirectory = $initialDirectory 
    $OpenFileDialog.filter = "All files (*.*)| *.*" 
    $OpenFileDialog.ShowDialog() | Out-Null 
    $OpenFileDialog.filename 
}

function DeleteUser () {
    Import-Csv $csvImport | ForEach-Object { 
        Remove-MsolUser -Force -userPrincipalName $_."UserPrincipalName"
        $usernamedelete = $_."UserPrincipalName"
        Write-Output "Deleting: $usernamedelete"
    }
}

$csvImport = Get-FileName -initialDirectory “C:\”

if ($null -ne $csvImport -and $csvImport -ne '') {
    DeleteUser
}else{
    Write-Output "Canceled !"
}
