
function ResolveIp($IpAddress) {
    try {
        (Resolve-DnsName $IpAddress -QuickTimeout -ErrorAction SilentlyContinue).NameHost
    } catch {
        $null
    }
}

function Get-PingSweep {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [string]$SubNet,
        [switch]$ResolveName
    )
    $ips = 1..255 | ForEach-Object {"$($SubNet).$_"}
    $ps = foreach ($ip in $ips) {
        (New-Object Net.NetworkInformation.Ping).SendPingAsync($ip, 250)
        #[Net.NetworkInformation.Ping]::New().SendPingAsync($ip, 250) # or if on PowerShell v5
    }
    [Threading.Tasks.Task]::WaitAll($ps)
    $ps.Result | Where-Object -FilterScript {$_.Status -eq 'Success' -and $_.Address -like "$subnet*"} |
    Select-Object Address,Status,RoundtripTime -Unique |
    ForEach-Object {
        if ($_.Status -eq 'Success') {
            if (!$ResolveName) {
                $_
            } else {
                $_ | Select-Object Address, @{Expression={ResolveIp($_.Address)};Label='Name'}, Status, RoundtripTime
            }
        }
    }
}



param($rede)

if (!$rede){
    echo "Pingsweep inspirado de @Lee_Holmes"
    echo "Ex .\pingSweep.ps1 -SubNet 192.168.0"
   # echo "Ex .\pingSweep.ps1 -SubNet 192.168.0 -ResolveName "
}else{
    Get-PingSweep -SubNet $rede
}



#Get-PingSweep -SubNet '10.10.10' -ResolveName


#(Measure-Command -Expression {Get-PingSweep -SubNet '10.10.10' -ResolveName}).Milliseconds
