variable "dns_zone_name" {
  type        = string
  description = "DNS zone name"
}

variable "dns_zone_resource_group" {
  type        = string
  description = "DNS zone resource group"
}

variable "vm_hostname" {
  type        = string
  default     = "myvm"
  description = "VM hostname"
}
variable "ssh_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "SSH pub key location"
}

variable "ssh_private_key" {
  description = "Path to the pprivate key to be used for ssh access to the VM. Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa."
  type        = string
  default     = "~/.ssh/id_rsa"
}

variable "source_address_prefixes" {
  description = "(Optional) List of source address prefixes allowed to access var.remote_port."
  type        = list(string)
}

variable "remote_port" {
  description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
  type        = string
  default     = ""
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  type        = string
  default     = "Standard_D2s_v3"
}