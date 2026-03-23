variable "resource_group_name" {
  type    = string
  default = "rg-uitware-task"
}

variable "location" {
  type    = string
  default = "polandcentral"
}

variable "vm_name" {
  type    = string
  default = "uitware-vm"
}

variable "admin_username" {
  type    = string
  default = "uitware_user"
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/uitware_task_key.pub"
}
