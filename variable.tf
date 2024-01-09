variable "cidr_block_vpc" {
  type        = string
  description = "This is cidr block vpc"
  default     = "10.17.0.0/24"
}

variable "vpc_tenancy" {
  type        = string
  default     = "default"
  description = "Instance tenancy for instance launched"
}

variable "dns_support_enable" {
  type        = bool
  default     = true
  description = "A boolean flag to enable/disable DNS support in the VPC"
}

variable "dns_hostnames_enable" {
  type        = bool
  default     = false
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
}

variable "vpc_name" {
  type        = string
  default     = "Main-VPC"
  description = "Name of the VPC"
}