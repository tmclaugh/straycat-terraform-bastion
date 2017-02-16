# Setup AWS provider
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
