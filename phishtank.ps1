$subscriptionId = "2b7e3cc8-a58b-416a-8609-66dba589f974"
$resourceGroupName = "phishtank-vm-rg"
$virtualMachineName = "phishtank-vm"
$osDiskName = "phishtankOSDisk"
$nicName = "phishtank-vm_nic" 
$publicIpName = "phishtank-vm_ip"

$snapshotResourceGroup = "phishtank-snapshot-rg"
$snapshotName = "phishtankvmsnapshot"
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

# delete the currupted vm along with its resources
echo "Removing Virtual Machine: " $virtualMachineName
Remove-AzureRmVM -Name $virtualMachineName -ResourceGroupName $resourceGroupName -Force -Verbose
echo "Deleting Disk:" $osDiskName
Remove-AzureRmDisk -Name $osDiskName -ResourceGroupName $resourceGroupName -Force -Verbose
echo "Deleting Network Interface: " $nicName
Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourceGroupName -Force -Verbose
echo "Removing Public IP Address" $publicIpName
Remove-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $resourceGroupName -Force -Verbose