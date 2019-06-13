variable "virtual_machine_name" {}
variable "location" {}
variable "admin_username" {}
variable "admin_password" {}
variable "prefix" {}
variable "susbcription_id" {}

variable "master_node_count" {}

variable "worker_node_count" {}

variable "master_vm_size" {
  description = "Size of the Master Node"
}
variable "worker_vm_size" {
  description = "Size of the Worker Nodes"
}

variable "master_inbound_ports" {
  type = "list"
}

variable "worker_inbound_ports" {
  type = "list"
}

variable "tags" {
  type = "map"

  default = {
    name = "mywebapp"
  }

  description = "Any tags which should be assigned to the resources in this example"
}
