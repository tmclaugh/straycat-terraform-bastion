
/*
* Define our global vars and any other setup elements.
*
* TODO: Handle multi-region in some manner
*/

variable "domain" {}

variable "environment" {}

variable "instance_key_name" {}

variable "aws_profile" {}

variable "aws_region" {
  default = "us-east-1"
}

# FIXME: replace hard coding with an aws provider var if I can figure out how
# to limit the list size.
#
# Also, how do I pass a list via tfvars?
variable "aws_availability_zones" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}


