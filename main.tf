/*
* bastion host
*/

// Variables
variable "domain" {}
variable "instance_key_name" {}
variable "account_id" {}
variable "aws_profile" {}
variable "aws_region" {}
variable "asg_min_size" {}
variable "asg_max_size" {}
variable "asg_desired_capacity" {}
variable "subnet_type" {}
variable "security_group_access" {}
variable "security_group_service_ingress" { type = "map" }
variable "security_group_default_ingress" { type = "map" }


// Setup AWS provider
provider "aws" {
  profile = "${var.aws_profile}"
  region  = "${var.aws_region}"
}

/*
* FIXME: can't gigure out how to handle personal repos.  Only orgs?
provider "github" {
  token         = "${var.github_token}"
  organization  = "${var.github_organization}"
}
*/

// Remote state for aws_vpc.
data "terraform_remote_state" "aws_vpc" {
  backend = "s3"
  config = {
    bucket  = "${var.domain}-${var.account_id}-terraform"
    key     = "aws_vpc.tfstate"
    region  = "${var.aws_region}"
  }
}

/*
* FIXME: can't gigure out how to handle personal repos.  Only orgs?
resource "github_repository" "bastion" {
  name = "straycat-terraform-bastion"
  description = "Terraform deploy of bastion host"

  has_issues = true
}
*/

/*
* Deploy Bastion host.
*/
module "bastion" {
  source                = "github.com/tmclaugh/tf_straycat_svc"
  svc_name              = "bastion"
  account_id            = "${var.account_id}"
  aws_region            = "${var.aws_region}"
  subnet_type           = "${var.subnet_type}"
  asg_min_size          = "${var.asg_min_size}"
  asg_max_size          = "${var.asg_max_size}"
  asg_desired_capacity  = "${var.asg_desired_capacity}"
  instance_key_name     = "${var.instance_key_name}"
  security_group_service_ingress_external = "${var.security_group_service_ingress}"
}

resource "aws_security_group_rule" "bastion_ssh_ingress" {
  type                      = "ingress"
  from_port                 = "${var.security_group_default_ingress["from_port"]}"
  to_port                   = "${var.security_group_default_ingress["to_port"]}"
  protocol                  = "${var.security_group_default_ingress["protocol"]}"
  source_security_group_id  = "${module.bastion.security_group_id}"
  security_group_id         = "${data.terraform_remote_state.aws_vpc.vpc.default_security_group_ids[var.security_group_access]}"
}

/*
* outputs
*/
output "launch_config_id" {
  value = "${module.bastion.launch_config_id}"
}

output "autoscaling_group_id" {
  value = "${module.bastion.autoscaling_group_id}"
}

output "autoscaling_group_name" {
  value = "${module.bastion.autoscaling_group_name}"
}

output "autoscaling_group_availability_zones" {
  value = "${module.bastion.autoscaling_group_availability_zones}"
}

output "autoscaling_group_min_size" {
  value = "${module.bastion.autoscaling_group_min_size}"
}

output "autoscaling_group_max_size" {
  value = "${module.bastion.autoscaling_group_max_size}"
}

output "autoscaling_group_desired_capacity" {
  value = "${module.bastion.autoscaling_group_desired_capacity}"
}

output "autoscaling_group_launch_configuration" {
  value = "${module.bastion.autoscaling_group_launch_configuration}"
}

output "autoscaling_group_vpc_zone_identifier" {
  value = "${module.bastion.autoscaling_group_vpc_zone_identifier}"
}

output "iam_role_arn" {
  value = "${module.bastion.iam_role_arn}"
}

output "iam_role_name" {
  value = "${module.bastion.iam_role_name}"
}

output "iam_instance_profile_arn" {
  value = "${module.bastion.iam_instance_profile_arn}"
}

output "iam_instance_profile_name" {
  value = "${module.bastion.iam_instance_profile_name}"
}

output "iam_instance_profile_roles" {
  value = "${module.bastion.iam_instance_profile_roles}"
}

output "security_group_id" {
  value = "${module.bastion.security_group_id}"
}

output "security_group_vpc_id" {
  value = "${module.bastion.security_group_vpc_id}"
}

output "security_group_name" {
  value = "${module.bastion.security_group_name}"
}

