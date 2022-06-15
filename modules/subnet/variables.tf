
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

variable "subnet_cidr_block" {
  description = "subnet cidr block"
  type        = string
}

variable "default_route_table_id" {
  description = "default route table id"
  type        = string
}
