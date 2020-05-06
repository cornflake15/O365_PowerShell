$username = 'admin username'
$password = 'admin password'

$secpassword = ConvertTo-SecureString $password -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($username, $secpassword)

Connect-MsolService -Credential $mycreds
Get-MsolAccountSku