# Module Main
# Below declared variables are common for all the resources

app_prefix  = "base"
env_prefix =  "sb" 
tags = {Application = "base", Environment = "sb", Purpose = "infrastructure provisioning", CreatedWith = "Terraform"}


# Module Resource Group
# Below declared variable creates the resource group with the given key as names and values as location.
          #RGNmae   
rg_names = [{rg_name_sufix = "base_rg" , location = "East US" , location_prefix = "eu"}]


# Module Virtual Network
# Below declared variables creates Virtual Network with the given values
virtualnetworks = {
    #VnetName         #VnetCIDR              #VnetRG
    app_vnet = {address = "10.10.0.0/16" , rg_index = 0},
    db_vnet  = {address = "10.20.0.0/16" , rg_index = 0}
}

# Module Virtual_Networks_Peering
## Below variable will create vnet peering if the value is any one of this list [yes,yeS,yES,YES,Yes,YEs,YeS]. 
#Else it will skip creating vnet peering for any other values [no,No,NO,nO]                                                  

create_vnetpeering = "yes" 

# Below declared variables creates subnets with the given values
subnets = {
    #SnetName         #SnetCIDR            #Snet'sVnet      #Snet'sNSG
    app_snet = {address = "10.10.1.0/24" , vnet_index = 0 , nsg_index = 0},
    db_snet  = {address = "10.20.1.0/24" , vnet_index = 1 , nsg_index = 0}
}

# Module Network Security Group
# Below declared variables creates Network Security Group and Security rules with the given values
nsg_with_rules = {

    "app_nsg" = {
        rg_index  = 0
        rules = [ {
            name                                       = "Allowed_In"
            priority                                   = 300
            direction                                  = "Inbound"
            access                                     = "Allow"
            protocol                                   = "*"
            source_port_range                          = "*"
            destination_port_range                     = ""
            source_port_ranges                         = []
            destination_port_ranges                    = ["22","443","3478"]
            source_address_prefix                      = "10.10.1.0/24"
            destination_address_prefix                 = "*"
            source_address_prefixes                    = []
            destination_address_prefixes               = []
            source_application_security_group_ids      = []
            destination_application_security_group_ids = []
            }
        ]
    }
    "db_nsg" = {
        rg_index  = 0
        rules = [ {
            name                                       = "Allowed_In"
            priority                                   = 400
            direction                                  = "Inbound"
            access                                     = "Allow"
            protocol                                   = "*"
            source_port_range                          = "*"
            destination_port_range                     = ""
            source_port_ranges                         = []
            destination_port_ranges                    = ["22","443","3478"]
            source_address_prefix                      = "10.20.1.0/24"
            destination_address_prefix                 = "*"
            source_address_prefixes                    = []
            destination_address_prefixes               = []
            source_application_security_group_ids      = []
            destination_application_security_group_ids = []
            }
        ]
    }
}

# Module Virtual_Machine
# Below declared variables virtual machines subnets with the given values
vm_details = {
    "avm" ={ 
        vm_count         = 1   
        rg_index         = 0
        subnet_index     = 0
        size             = "Standard_B1ls"
        username         = "evertz"
        password         = "evertzprime@123"
        disk_type        = "Standard_LRS"
        os_image         = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS" 
            version   = "latest"
        }
    },
    "bvm" ={    
        vm_count          = 1
        rg_index          = 0
        subnet_index      = 1
        size              = "Standard_B1ls"
        username          = "evertz"
        password          = "evertzprime@123"
        disk_type         = "Standard_LRS"
        os_image          = {
            publisher = "Canonical"
            offer     = "UbuntuServer"
            sku       = "18.04-LTS" 
            version   = "latest"
        }
    }
}


# Module Role Assignment for users
# Below declared variables provides Role Definition to the users for resource group

run_urole_module = "No" # This variable will allow assigning role definitions to users i.e., keys(userroles).

userroles = { 
     
    "sbulusu@primesoft.net" = {rg_index = 0 , role_defs = ["Reader"]},
    "sdhabole@primesoft.net"  = {rg_index = 0 , role_defs = ["Owner", "Reader"]},
    "rmuragani@primesoft.net"   = {rg_index = 0 , role_defs = ["Owner","Reader"]}
}