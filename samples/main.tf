provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

module "linuxservers" {
  source                  = "../"
  resource_group_name     = azurerm_resource_group.example.name
  vm_os_simple            = "UbuntuServer"
  vnet_subnet_id          = module.network.vnet_subnets[0]
  has_custom_dns          = true
  dns_zone_name           = var.dns_zone_name
  dns_zone_resource_group = var.dns_zone_resource_group
  vm_hostname             = var.vm_hostname
  ssh_key                 = var.ssh_key
  ssh_private_key         = var.ssh_private_key
  remote_port             = var.remote_port
  source_address_prefixes = var.source_address_prefixes
  custom_data             = base64encode(data.template_file.cloud-init.rendered)

  depends_on = [azurerm_resource_group.example]
}

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.example.name
  subnet_prefixes     = ["10.0.1.0/24"]
  subnet_names        = ["default"]

  depends_on = [azurerm_resource_group.example]
}

data "template_file" "cloud-init" {
  template = file("caprover.sh")
  # vars = {
  # }
}