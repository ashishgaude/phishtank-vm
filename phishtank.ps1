$subscriptionId = $args[2]          # "2b7e3cc8-a58b-416a-8609-66dba589f974"    SUBSCRIPTION
$resourceGroupName = $args[3]       # "phishtank-vm-rg"                         RESOURCE_GROUP
$virtualMachineName = $args[4]      # "phishtank-vm"                            VM
$nicName = $args[5]                 # "phishtank-vm_nic"                        NIC
$publicIpName = $args[6]            # "phishtank-vm_ip"                         PUBLIC_IP

$snapshotResourceGroup = $args[7]   # "phishtank-snapshot-rg"                   SNAPSHOT_RESOURCE_GROUP
$snapshotName = $args[8]            # "phishtankvmsnapshot"                     SNAPSHOT
$osDiskName = $args[9]              # "phishtankOSDisk"                         OS_DISK
$virtualNetworkName = $args[10]     # "phishtank-vmVNET"                        VIRTUAL_NETWORK
$virtualMachineSize = $args[11]     # "Standard_D8_v3"                          VM_TIER

$username = $args[0]                # "ashish@numinolabs.com"                   AZURE_USER
$password = $args[1]                # "numino@123"                              AZURE_PASSWORD
$securePassword = ConvertTo-SecureString -String $password -AsPlainText -Force


# login to Azure
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)
echo "Login in to Azure:"
Add-AzureRmAccount -Credential $cred
echo "Setting up the subscription to " $subscriptionId
Set-AzureRMContext -SubscriptionId $subscriptionId


# delete the currupted vm along with its resources
Remove-AzureRmVM -Name $virtualMachineName -ResourceGroupName $resourceGroupName -Force -Verbose
Remove-AzureRmDisk -Name $osDiskName -ResourceGroupName $resourceGroupName -Force -Verbose
Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourceGroupName -Force -Verbose
Remove-AzureRmPublicIpAddress -Name $publicIpName -ResourceGroupName $resourceGroupName -Force -Verbose


# Creating virtual machine
echo "Fetching the Snapshot..."
$snapshot = Get-AzureRmSnapshot -ResourceGroupName $snapshotResourceGroup -SnapshotName $snapshotName 
$diskConfig = New-AzureRmDiskConfig -AccountType $storageType -Location $snapshot.Location -SourceResourceId $snapshot.Id -CreateOption Copy
echo "Creating Disk..."
$disk = New-AzureRmDisk -Disk $diskConfig -ResourceGroupName $resourceGroupName -DiskName $osDiskName
echo "Creating Virtual Machine Object..."
$VirtualMachine = New-AzureRmVMConfig -VMName $virtualMachineName -VMSize $virtualMachineSize
echo "Creating OS Disk..."
$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -ManagedDiskId $disk.Id -CreateOption Attach -Windows
echo "Creating public IP..."
$publicIp = New-AzureRmPublicIpAddress -Name ($VirtualMachineName.ToLower() + '_ip') -ResourceGroupName $resourceGroupName -Location $snapshot.Location -AllocationMethod Dynamic
echo "Getting Virtual Network..."
$vnet = Get-AzureRmVirtualNetwork -Name $virtualNetworkName -ResourceGroupName $resourceGroupName
echo "Creating Network Interface..."
$nic = New-AzureRmNetworkInterface -Name ($VirtualMachineName.ToLower() + '_nic') -ResourceGroupName $resourceGroupName -Location $snapshot.Location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $publicIp.Id
echo "Attach NIC to VM object"
$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $nic.Id
echo "Creating VIRTUAL MACHINE..."
New-AzureRmVM -VM $VirtualMachine -ResourceGroupName $resourceGroupName -Location $snapshot.Location