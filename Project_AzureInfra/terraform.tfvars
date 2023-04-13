rg_name = "MainRG"
location = {SI = "South India"}
cidr_range = ["10.10.0.0/20","10.11.0.0/20"]
subnetA_map =     {
    AzureFirewallSubnet  = "10.10.1.0/24"
    AzureBastionSubnet   = "10.10.2.0/24"
}
subnetB_map = {
    ApplicationSubnet    = "10.11.1.0/24"
    JumpboxSubnet        = "10.11.2.0/24"
}

nic_list = [ 
    {
        nic_name = "Gate-srv1"
        nic_ip   = "10.11.1.25"
    },
    {
        nic_name = "Way-srv1"
        nic_ip   = "10.11.1.26"
    }
]
