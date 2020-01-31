$azSubs = Get-AzSubscription | Where-Object { $_.Name -Clike "*Internal*" }

foreach ( $azSub in $azSubs ) {
    
    Write-Output $azSub

    Set-AzContext -Subscription $azSub | Out-Null

    $RGs = Get-AzResourceGroup

    #foreach ( $rg in $RGs){
        
        
        $VMs = Get-AzVM

            foreach ($VM in $VMs) { 
                try{
                 $VMExt = Get-AzVMExtension -ResourceGroupName $VM.ResourceGroupName -VMName $VM.Name
                 }
                 catch{
                   # Write-Host $_
                 }            
        
                if($VMExt){
                   Write-Output   "The Extensions for $($VM.Name) are $($VMExt.Name) "
                }                
     
            } 
    }

#}
