variable "environment" {
  description = "environment"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
}

variable "vpc_cidr_block" {
  description = "vpc cidr block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  type        = string
}

variable "my_ip_address" {
  description = "my ip address"
  type        = string
}

variable "server_instance_type" {
  description = "server instance type"
  type        = string
}

variable "public_key_location" {
  description = "public key location"
  type        = string
}

variable "private_key_location" {
  description = "private key location"
  type        = string
}
