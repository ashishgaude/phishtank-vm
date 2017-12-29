$securePassword = ConvertTo-SecureString -String $args[1] -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential ($args[0], $securePassword)
Add-AzureRmAccount -Credential $cred
