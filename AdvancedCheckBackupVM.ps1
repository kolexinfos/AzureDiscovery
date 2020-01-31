$azSubs = Get-AzSubscription | Where-Object { $_.Name -notlike "*Azure Active Directory*" }

foreach ( $azSub in $azSubs ) {

Set-AzContext -Subscription $azSub | Out-Null 

$VMs = Get-AzVM

foreach ($VM in $VMs) {
    
  #$VMInfo = Get-AzVM -Name $VM.Name
  #Write-Output $VM.Name

  $status = Get-AzRecoveryServicesBackupStatus -Name $VM.Name -ResourceGroupName $VM.ResourceGroupName -Type "AzureVM" 

  Write-Output  "Does the VM  $($VM.Name) have a backup in recovery vault? :  $($status.BackedUp)"

  if($status.VaultId) { 

    $rsv = $status.VaultId.Split('/')[-1]  

    Write-Output "The VM $($VM.Name) is member of RSV $($rsv)"  

    } 
} 
}