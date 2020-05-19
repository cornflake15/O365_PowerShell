
Function Get-FileName($initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
    Out-Null 

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
    $OpenFileDialog.initialDirectory = $initialDirectory 
    $OpenFileDialog.filter = "All files (*.*)| *.*" 
    $OpenFileDialog.ShowDialog() | Out-Null 
    $OpenFileDialog.filename 
}

function ChangePassword () {
    Import-Csv $csvImport | ForEach-Object { 
        $username = $_."UserName"
        $newpassword = "#AlwaysTheFirst#" + $_."PasswordSion"
        Set-MsolUserPassword -UserPrincipalName $username -NewPassword $newpassword
    }
}

$csvImport = Get-FileName -initialDirectory “c:\”

if ($null -ne $csvImport -and $csvImport -ne '') {
    ChangePassword
}else{
    Write-Output "Canceled !"
}
