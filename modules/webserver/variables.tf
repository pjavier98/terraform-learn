variable "environment" {
  description = "environment"
  type        = string
}

variable "vpc_id" {
  description = "vpc id"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
}

variable "my_ip_address" {
  description = "my ip address"
  type        = string
}

variable "image_name" {
  description = "server image name"
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
