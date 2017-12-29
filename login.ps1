$username = "ashish@numinolabs.com"
$securePassword = ConvertTo-SecureString -String "xxx-xxx" -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
Add-AzureRmAccount -Credential $cred
