rgname = [ {rg_name = "rbt1-rg",location = "East US"} ]

vnet = [ 
{vnetname = "rbt1-vnet",cidr = "10.1.0.0/16", rg_index = 0}, 
{vnetname = "rbt2-vnet",cidr = "10.2.0.0/16", rg_index = 0} 
]

subnet = [ 
{snetname = "rbt1-snet",scidr = "10.1.1.0/24", vnet_index = 0}, 
{snetname = "rbt2-snet",scidr = "10.2.1.0/24", vnet_index = 1} 
]

aksdetails = [ {
  aksname = "rbt-aks"
  rg_index = 0
  nodecount = 1
  nodesize = "Standard_D2_v2"
} ]

vm_details = [ {
        vm_name          = "rbt-vm"
        vm_count         = 1   
        rg_index         = 0
        subnet_index     = 0
        size             = "Standard_B1ls"
        username         = "rbt"
        password         = "raybiztech@123"
        disk_type        = "Standard_LRS"
        os_image         = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS" 
            version   = "latest"
        }
} ]