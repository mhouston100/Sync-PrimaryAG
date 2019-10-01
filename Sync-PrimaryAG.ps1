import-module dbatools

foreach ($curAvailabilityGroup in (Get-DbaAvailabilityGroup -SqlInstance $clusterName | Where-Object {$_.PrimaryReplica -eq $ENV:COMPUTERNAME})){
    Sync-DbaAvailabilityGroup -Primary $ENV:COMPUTERNAME -AvailabilityGroup $curAvailabilityGroup.AvailabilityGroup -WhatIf
}