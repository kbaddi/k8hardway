resource "azurerm_network_security_group" "k8hway" {
  name                = "kubedemo"
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_network_security_rule" "k8hway" {
  count                       = "${length(var.inbound_port_ranges)}"
  name                        = "sgrule-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = "${(100 * (count.index + 1))}"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "${element(var.inbound_port_ranges, count.index)}"
  protocol                    = "TCP"
  resource_group_name         = "${azurerm_resource_group.main.name}"
  network_security_group_name = "${azurerm_network_security_group.k8hway.name}"
}
