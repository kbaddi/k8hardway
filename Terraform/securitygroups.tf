resource "azurerm_network_security_group" "k8hway" {
  name                = "webservers"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  security_rule {
    count     = 5
    name      = "sg-rule-${count.index}"
    direction = "Inbound"
    access    = "Allow"

    # priority                   = 
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "${element(var.inbound_port_ranges, count.index)}"
    protocol                   = "TCP"
  }
}
