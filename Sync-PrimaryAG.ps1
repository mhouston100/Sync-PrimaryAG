import-module .\dbatools

If (Get-Cluster){
    $clusterName = Get-Cluster
} else {
    Write-Error "Not member of cluster, exiting"
    exit
}

Sync-DbaAvailabilityGroup -Primary $clusterName | Out-Null