rgname = [ {rg_name = "PrimeSquare-rg",location = "Central India"} ]

vnet = [ 
{vnetname = "PrimeSquare-IAC1-vnet",cidr = "10.1.0.0/16", rg_index = 0}, 
{vnetname = "PrimeSquare-IAC2-vnet",cidr = "10.2.0.0/16", rg_index = 0} 
]

subnet = [ 
{snetname = "PrimeSquare-IAC1-snet",scidr = "10.1.1.0/24", vnet_index = 0}, 
{snetname = "PrimeSquare-IAC2-snet",scidr = "10.2.1.0/24", vnet_index = 1} 
]

vm_details = [ {
        vm_name          = "PrimeSquare-IAC-vm"
        vm_count         = 1   
        rg_index         = 0
        subnet_index     = 0
        size             = "Standard_DS1_v2"
        username         = "ubuntu"
        password         = "Primesoft@123"
        disk_type        = "Standard_LRS"
        os_image         = {
            publisher = "Canonical"
            offer     = "0001-com-ubuntu-server-jammy"
            sku       = "22_04-lts" 
            version   = "latest"
        }
} ]