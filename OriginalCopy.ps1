Do { 

$VMName = Read-Host "Enter VM Name" 

} while (!$VMName) 

 
 

$azSubs = Get-AzSubscription | Where-Object { $_.Name -notlike "*Azure Active Directory*" } 

 
 

$VM = 0 

foreach ( $azSub in $azSubs ) { 

Set-AzContext -Subscription $azSub | Out-Null 

$VMInfo = Get-AzVM -Name $VmName 

if ($VMInfo) { 

$VM++ 

$status = Get-AzRecoveryServicesBackupStatus -Name $VMname -ResourceGroupName $VMInfo.ResourceGroupName -Type "AzureVM" 

If ($status.VaultId) { 

$rsv = $status.VaultId.Split('/')[-1]  

Write-Output "The VM &lt; $VMName &gt; is member of RSV &lt; $rsv &gt;"  

} 

If ($status.BackedUp -eq $false) { 

Write-Output "The VM &lt; $VMName &gt; is not protected with Azure Backup. You should consider enable it!"  

}  

} 

} 

 
 

If ($VM -eq 0) { 

Write-Warning "The Azure VM &lt; $VMName &gt; cannot be found. Please check your virtual machine name!"  

} 