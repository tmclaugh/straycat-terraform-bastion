terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an S3 bucket
  remote_state {
    backend = "s3"
    config {
      encrypt = "true"
      bucket  = "straycat-dhs-org-straycat-terraform"
      key     = "bastion.tfstate"
      region  = "us-east-1"
    }
  }
}

/*
* aws vars for Terraform
*/
svc_name = "bastion"

aws_s3_prefix           = "straycat-dhs-org"
aws_account             = "straycat"  # AWS credentials profile name
aws_profile             = "straycat"
aws_region              = "us-east-1"

asg_min_size            = 0
asg_max_size            = 0
asg_desired_capacity    = 0

subnet_type = "public"

security_group_service_ingress = {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_block = "0.0.0.0/0"
}

# We control what this bastion is able to tack to from here.
security_group_access = ["public", "private"]
security_group_default_ingress = {
  from_port             = 22
  to_port               = 22
  protocol              = "tcp"
}

# Does not yet work.
github_organization     = "tmclaugh"
