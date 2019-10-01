import-module dbatools

If (Get-Cluster){
    $clusterName = (Get-Cluster).Name
    Write-Output "Cluster found : $clusterName "
} else {
    Write-Error "Not member of cluster, exiting"
    exit
}

foreach ($curAvailabilityGroup in (Get-DbaAvailabilityGroup -SqlInstance $clusterName | Where-Object {$_.PrimaryReplica -eq $ENV:COMPUTERNAME})){
    Sync-DbaAvailabilityGroup -Primary $ENV:COMPUTERNAME -AvailabilityGroup $curAvailabilityGroup.AvailabilityGroup -WhatIf
}