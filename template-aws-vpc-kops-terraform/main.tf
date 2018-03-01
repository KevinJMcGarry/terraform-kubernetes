module "vpc" {
  source   = "./modules/vpc"
  name     = "${var.name}"
  env      = "${var.env}"
  vpc_cidr = "${var.vpc_cidr}"

  tags {
    Infra             = "${var.name}"
    Environment       = "${var.env}"
    Terraformed       = "true"
    KubernetesCluster = "${var.env}.${var.name}"
  }
}

module "subnet_pair" {
  source              = "./modules/subnet-pair"
  name                = "${var.name}"
  env                 = "${var.env}"
  vpc_id              = "${module.vpc.vpc_id}"
  vpc_cidr            = "${module.vpc.cidr_block}"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  availability_zones  = "${var.azs}"

  tags {
    Infra             = "${var.name}"
    Environment       = "${var.env}"
    Terraformed       = "true"
    KubernetesCluster = "${var.env}.${var.name}"
  }
}

# this block is only used if you haven't already registered a zone in Route 53
#resource "aws_route53_zone" "public" {
#  name          = "${var.name}"
#  force_destroy = true
#
#  tags {
#    Name        = "${var.name}-${var.env}-zone-public"
#    Infra       = "${var.name}"
#    Environment = "${var.env}"
#    Terraformed = "true"
#  }
#}

# bucket for storing KOPS cluster state info
resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.name}-state"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.name}-${var.env}-kops-state-store"
    Infra       = "${var.name}"
    Environment = "${var.env}"
    Terraformed = "true"
  }
}
