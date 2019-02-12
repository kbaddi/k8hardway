resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = "${var.location}"
  tags     = "${var.tags}"
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_public_ip" "main" {
  count = "${var.node_count}"
  name                         = "${var.prefix}-${count.index}-pip"
  resource_group_name          = "${azurerm_resource_group.main.name}"
  location                     = "${azurerm_resource_group.main.location}"
  public_ip_address_allocation = "static"
  tags                         = "${var.tags}"
}

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
resource "azurerm_network_interface" "main" {
  count = "${var.node_count}"
  name                      = "${var.prefix}-nic-${count.index}"
  location                  = "${azurerm_resource_group.main.location}"
  resource_group_name       = "${azurerm_resource_group.main.name}"
  network_security_group_id = "${azurerm_network_security_group.web.id}"

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = "${azurerm_subnet.internal.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${element(azurerm_public_ip.main.*.id, count.index)}" 
    
  }
}
