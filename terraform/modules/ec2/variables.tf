variable "project_name" {
  description = "Project name tag."
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prd)."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet to launch the EC2 instance in."
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach to the EC2 instance."
  type        = string
}

variable "key_pair_name" {
  description = "The name of the EC2 Key Pair."
  type        = string
}

variable "associate_public_ip" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = false
}

variable "iam_instance_profile_name" {
  description = "IAM instance profile name"
  type = string
}