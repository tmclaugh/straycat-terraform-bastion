# bastion host
output "bastion.instance_bastion_id" {
  value = "${module.bastion.instance_bastion_id}"
}

output "bastion.instance_public_dns" {
  value = "${module.bastion.instance_public_dns}"
}

output "bastion.security_group_bastion_id" {
  value = "${module.bastion.security_group_bastion_id}"
}

output "bastion.security_group_rule_vpc_allow_bastion_ssh_ids" {
  value = "${module.bastion.security_group_rule_vpc_allow_bastion_ssh_ids}"
}

/*
* FIXME: can't gigure out how to handle personal repos.  Only orgs?
output "bastion.ssh_clone_url" {
  value = "${github_repository.bastion.ssh_clone_url}"
}
*/
