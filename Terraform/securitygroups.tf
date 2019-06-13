# Security Group for Master Node

resource "azurerm_network_security_group" "master" {
  name                = "master"
  location            = "${azurerm_resource_group.k8hway.location}"
  resource_group_name = "${azurerm_resource_group.k8hway.name}"
}

resource "azurerm_network_security_rule" "master" {
  count                       = "${length(var.master_inbound_ports)}"
  name                        = "sgrule-master-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = "${(100 * (count.index + 1))}"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "${element(var.master_inbound_ports, count.index)}"
  protocol                    = "TCP"
  resource_group_name         = "${azurerm_resource_group.k8hway.name}"
  network_security_group_name = "${azurerm_network_security_group.master.name}"
}


# Security Group for Worker  Node
resource "azurerm_network_security_group" "worker" {
  name                = "worker"
  location            = "${azurerm_resource_group.k8hway.location}"
  resource_group_name = "${azurerm_resource_group.k8hway.name}"
}

resource "azurerm_network_security_rule" "worker" {
  count                       = "${length(var.worker_inbound_ports)}"
  name                        = "sgrule-worker-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = "${(100 * (count.index + 1))}"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = "${element(var.worker_inbound_ports, count.index)}"
  protocol                    = "TCP"
  resource_group_name         = "${azurerm_resource_group.k8hway.name}"
  network_security_group_name = "${azurerm_network_security_group.worker.name}"
}
