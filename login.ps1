$subscriptionId = "2b7e3cc8-a58b-416a-8609-66dba589f974"
$resourceGroupName = "phishtank-vm-rg"
$virtualMachineName = "phishtank-vm"
$disk = "phishtankOSDisk"
$nicName = "phishtank-vm_nic" 
$publicIpName = "phishtank-vm_ip"

$snapshotResourceGroup = "phishtank-snapshot-rg"
$snapshotName = "phishtankvmsnapshot"
$osDiskName = "phishtankOSDisk"
$virtualNetworkName = 'phishtank-vmVNET'
$virtualMachineSize = 'Standard_D8_v3'

$username = "ashish@numinolabs.com"
$securePassword = ConvertTo-SecureString -String "xxx-xxx" -AsPlainText -Force


# login to Azure
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
Add-AzureRmAccount -Credential $cred
Set-AzureRMContext -SubscriptionId $subscriptionId