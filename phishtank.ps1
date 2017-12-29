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

$username = $args[0]
$securePassword = ConvertTo-SecureString -String $args[1] -AsPlainText -Force


# login to Azure
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
echo "Login in to Azure:"
Add-AzureRmAccount -Credential $cred
echo "Setting up the subscription to " $subscriptionId
Set-AzureRMContext -SubscriptionId $subscriptionId