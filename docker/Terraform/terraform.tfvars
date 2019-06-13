virtual_machine_name = "master"

location = "eastus"

admin_username = "kubeamdin"

admin_password = "$3cureel0ve"

prefix = "web"

susbcription_id = "8d4847a9-69e0-421a-a34c-bdbe015475c7"

master_node_count = 1

worker_node_count = 2

master_inbound_ports = ["22", "443", "80"]

worker_inbound_ports = ["8080"]

master_vm_size = "Standard_D4_v3"

worker_vm_size = "Standard_D2_v3"

destination_ssh_key_path = "/home/kubeamdin/.ssh/authorized_keys"
