import-module "$env:CamPSModulePath\dbatools\dbatools.psm1"

If (Get-Cluster){
    $clusterName = (Get-Cluster).Name
    Write-Output "Cluster found : $clusterName "
} else {
    Write-Error "Not member of cluster, exiting"
    exit
}

#Sync-DbaAvailabilityGroup -Primary $clusterName -Secondary | Out-Null