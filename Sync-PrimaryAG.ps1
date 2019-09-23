param(
    [Parameter(Mandatory = $True)]
    [string]
    $clusterName
)

import-module dbatools


$availabiltiyGroups = Get-DbaAvailabilityGroup -SqlInstance $clusterName 

Foreach ($availabiltiyGroup in $availabiltiyGroups){
    $curPrimary = $availabiltiyGroup.PrimaryReplica
    Write-Output "Current Primary is $curPrimary"
    Foreach ($curReplica in $availabiltiyGroup.AvailabilityReplicas.Name){
        If ($curReplica -ne $curPrimary){
            Write-Output "Processing : Sync $curPrimary to replica $($curReplica)"
            Sync-DbaAvailabilityGroup -Primary $curPrimary -Secondary $curReplica | Out-Null
        }
        else {
            Write-Output "Replica Name ($curReplica) is the same as Primary Name ($curPrimary)"
        }
    }
}