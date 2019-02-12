resource "azurerm_network_security_group" "web" {
  name     = "webservers"
  location = "${azurerm_resource_group.main.location}"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  security_rule  {
      name                       = "ssh-access-rule"
      direction                  = "Inbound"
      access                     = "Allow"
      priority                   = 200
      source_address_prefix      = "*"
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      protocol                   = "TCP"
    }

  security_rule { 
    name                       = "http-rule"
    direction                  = "Inbound"
    access                     = "Allow"
    priority                   = 300
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "80"
    protocol                   = "TCP"
  }
  security_rule { 
    name                       = "kube-port"
    direction                  = "Inbound"
    access                     = "Allow"
    priority                   = 400
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "8080"
    protocol                   = "TCP"
  }
}