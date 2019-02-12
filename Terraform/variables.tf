variable "virtual_machine_name" {}
variable "location" {}
variable "admin_username" {}
variable "admin_password" {}
variable "prefix" {}
variable "susbcription_id" {}
variable "node_count" {}

variable "virtual_machine_size" {}

variable "tags" {
  type = "map"

  default = {
    name = "mywebapp"
  }

  description = "Any tags which should be assigned to the resources in this example"
}
