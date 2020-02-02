$azSubs = Get-AzSubscription #| Where-Object { $_.Name -Clike "*Azure Active Directory*" }

foreach ( $azSub in $azSubs ) {

Set-AzContext -Subscription $azSub | Out-Null 

$VMs = Get-AzVM

foreach ($VM in $VMs) {
        
        if(!$VM.StorageProfile.OsDisk){
            Write-Output  "The VM $($VM.Name) does not use managed disks" 
        }
        else{
         Write-Output  "The VM $($VM.Name) uses managed disks"    
        }
     
    } 
}