$azSubs = Get-AzSubscription | Where-Object { $_.Name -Clike "*Internal*" }

foreach ( $azSub in $azSubs ) {
    
    #Write-Output $azSub

    Set-AzContext -Subscription $azSub | Out-Null

    $RGs = Get-AzResourceGroup

    foreach ( $rg in $RGs){
        
        #Write-Output $rg
        $nsgs = Get-AzureRmNetworkSecurityGroup  -ResourceGroupName $rg.ResourceGroupName           

            foreach ($nsg in $nsgs) {

                #Write-Output $nsg.Name
                #Write-Output $nsg.NetworkInterfaces.Count                
        
                if($nsg.NetworkInterfaces.Count -gt 0){
                   Write-Output   "The NSG $($nsg.Name) is connected to $($nsg.NetworkInterfaces.Count) Network Interface(s) "
                }

                #Write-Output $nsg.NetworkInterfaces
     
            } 
    }

}
