
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
    $licensesForMhs = 'your SKU'
    $defaultPassword = 'User default password'

    Import-Csv $csvImport | ForEach-Object { 
        New-Msoluser -userPrincipalName $_."UserName" -displayname $_."DisplayName" -password $defaultPassword -ForceChangePassword $true -usagelocation "id"
        Set-MsolUserLicense -userPrincipalName $_."UserName" -AddLicenses $licensesForMhs
    }
}

$csvImport = Get-FileName -initialDirectory “c:\”

if ($null -ne $csvImport -and $csvImport -ne '') {
    CreateUser
}else{
    Write-Output "Canceled !"
}
