variable "project_name" {
  description = "Project Name tag,"
  type = string
}

variable "environment" {
  description = "Deployment Environment."
  type = string
}

variable "vpc_cidr" {
 description = "CIDR Block for the VPC." 
 type = string
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones to use."
  type        = list(string)
}