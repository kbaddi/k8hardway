resource "azurerm_resource_group" "k8hway" {
  name     = "${var.prefix}-group"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_virtual_network" "k8hway" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.k8hway.location}"
  resource_group_name = "${azurerm_resource_group.k8hway.name}"
  tags                = "${var.tags}"

}

resource "azurerm_subnet" "external" {
  name                 = "external"
  resource_group_name  = "${azurerm_resource_group.k8hway.name}"
  virtual_network_name = "${azurerm_virtual_network.k8hway.name}"
  address_prefix       = "10.0.1.0/24"
}

  resource "azurerm_public_ip" "master" {
    count                        = "${var.master_node_count}"
    name                         = "${var.prefix}-${count.index}-pip"
    resource_group_name          = "${azurerm_resource_group.k8hway.name}"
    location                     = "${azurerm_resource_group.k8hway.location}"
    public_ip_address_allocation = "static"
    sku                          = "Standard"
    tags                         = "${var.tags}"
  }

resource "azurerm_network_interface" "master" {
  count                     = "${var.master_node_count}"
  name                      = "${var.prefix}-nic-${count.index}"
  location                  = "${azurerm_resource_group.k8hway.location}"
  resource_group_name       = "${azurerm_resource_group.k8hway.name}"
  network_security_group_id = "${azurerm_network_security_group.master.id}"

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = "${azurerm_subnet.external.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${element(azurerm_public_ip.master.*.id, count.index)}"

  }
}
