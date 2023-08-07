# Define the destination network and gateway address
$destinationNetwork = "192.168.100.0"   # Change this to the desired destination network
$subnetMask = "255.255.255.0"           # Change this to the appropriate subnet mask
$gateway = "192.168.1.1"                # Change this to the gateway address

# Add the static route
Add-NetRoute -DestinationPrefix $destinationNetwork -PrefixLength $subnetMask -NextHop $gateway
