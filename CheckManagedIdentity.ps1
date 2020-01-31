$azSubs = Get-AzSubscription | Where-Object { $_.Name -notlike "*Azure Active Directory*" }

foreach ( $azSub in $azSubs ) {

Set-AzContext -Subscription $azSub | Out-Null 

$VMs = Get-AzVM

foreach ($VM in $VMs) {
        
        $serv = Get-AzADServicePrincipal -DisplayName $VM.Name

        if($serv){
            
        }

        Write-Output $serv  #"The VM $($VM.Name) uses service principal  $($serv)" 
     
    } 
}