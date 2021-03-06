function Get-DNSWINS {
	param(
		[string[]]$ComputerName= "."
	)
#Get NICS via WMI
$NICs = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $ComputerName -Filter "IPEnabled=TRUE"

	foreach($NIC in $NICs) {
		$arrNics = @()
		$params = @{
			Computer = $NIC.PSComputerName
			Index = $NIC.Index
			Name = ($NIC.Caption).substring(11)
			IPAddress = $NIC.IPAddress
			DNSServers = $NIC.DNSServerSearchOrder
			WINSServers = $NIC.WINSPrimaryServer, $NIC.WINSSecondaryServer			
		}
		write-verbose "Creating Nic Object"
		$objNIC = New-Object -TypeName PSObject -Property $params
		Write-Verbose "Adding Nic"
		$arrNICs += $objNIC
		$arrNICs
	}
}
