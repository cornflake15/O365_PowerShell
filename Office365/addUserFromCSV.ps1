
Function Get-FileName($initialDirectory){
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | 
    Out-Null 

    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog 
    $OpenFileDialog.initialDirectory = $initialDirectory 
    $OpenFileDialog.filter = "All files (*.*)| *.*" 
    $OpenFileDialog.ShowDialog() | Out-Null 
    $OpenFileDialog.filename 
}

function CreateUser () {
    $licensesForMhs = '<licenses-name>', '<licenses-name>'
    #$licensesForKaryawan = '<licenses-name>', '<licenses-name>'
    $defaultPassword = '<user password>'

    Import-Csv $csvImport | ForEach-Object { 
        New-Msoluser -userPrincipalName $_."UserName" -displayname $_."DisplayName" -password $defaultPassword -ForceChangePassword $true -usagelocation "id"
        Set-MsolUserLicense -userPrincipalName $_."UserName" -AddLicenses $licensesForMhs
        #$adds = $_."UserName"
        #Write-Output "Adding $adds"
    }
}

$csvImport = Get-FileName -initialDirectory “c:\”

if ($null -ne $csvImport -and $csvImport -ne '') {
    CreateUser
}else{
    Write-Output "Canceled !"
}
