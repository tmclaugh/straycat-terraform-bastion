
module "bastion" {
  source            = "./modules/bastion"
  instance_key_name = "${var.instance_key_name}"
  instance_security_group_id_default = "${data.terraform_remote_state.infrastructure.vpc_public.default_security_group_id}"

  instance_subnet_id = "${
    lookup(
      data.terraform_remote_state.infrastructure.vpc_public.subnet_id_by_availability_zone_public,
      var.aws_availability_zones[0]
    )
  }"

  instance_vpc_name             = "${data.terraform_remote_state.infrastructure.vpc_public.vpc_name}"
  instance_vpc_id               = "${data.terraform_remote_state.infrastructure.vpc_public.vpc_id}"
  security_group_other_vpc_sgs  = {
    private = "${data.terraform_remote_state.infrastructure.vpc_private.default_security_group_id}"
  }
}
