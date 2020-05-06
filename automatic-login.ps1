$username = "support_microsoft365@stikom-bali.ac.id"
$password = "#ITBStikomBali21042020#"

$secpassword = ConvertTo-SecureString $password -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential($username, $secpassword)

Connect-MsolService -Credential $mycreds
Get-MsolAccountSku