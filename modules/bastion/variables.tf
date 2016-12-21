/*
* Variables
*/

# FIXME: This should be provided by infrastructure.
variable "instance_ami_id" {
  type = "string"
  description = "AMI ID for bastion host."
  default = "ami-b73b63a0"
}

variable "instance_key_name" {
  type = "string"
  description = "SSH key for instance"
}

variable "instance_subnet_id" {
  type = "string"
  description = "Subnet ID to place instance."
}

variable "instance_type" {
  type = "string"
  description = "Instance type for bastion host."
  default = "t2.micro"
}

variable "instance_security_group_id_default" {
  type = "string"
  description = "ID for default SG of the VPC the instance will live in."
}

variable "instance_vpc_name" {
  type = "string"
  description = "Name of VPC bastion will live in."
}

variable "instance_vpc_id" {
  type = "string"
  description = "ID of VPC bastion will live in."
}

# FIXME: We can't calculate the length of a list that contains module outputs
# or data source values.  Right now we accept and handle a singe VPC as a
# string.
#
# ref. https://github.com/hashicorp/terraform/issues/3888
variable "security_group_other_vpc_sgs" {
  type = "string"
  description = "A single VPC even though we should handle a list..."
  default = ""
}

