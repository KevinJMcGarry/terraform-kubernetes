module "vpc" {
  source   = "../modules/vpc"
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
  source              = "../modules/subnet-pair"
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

# IF THE ROOT DOMAIN ZONE ALREADY EXISTS, YOU MUST FIRST IMPORT IT WITH THIS STATEMENT
# SUBSTITUTE PROPER VALUES FOR THE ZONE NAME AND ZONE ID
# terraform import aws_route53_zone.popularnoise-com Z2NXJ40RLXM0QB

# note - terraform destroy will not delete your root zone or sub-domain zone
# if the root zone was created manually first

resource "aws_route53_zone" "eureka-software" {
  name = "eureka.software."
}

# K8S sub-domain for ohio region
resource "aws_route53_zone" "k8s-virginia-eureka-software" {
   name = "k8s-virginia.eureka.software"
}

# below is for populating sub-domain NS records into the parent zone
resource "aws_route53_record" "k8s-virginia-eureka-software-ns" {
   zone_id = "${aws_route53_zone.eureka-software.zone_id}"
   name = "k8s-virginia.eureka.software"
   type = "NS"
   ttl = "30"
   records = [
    "${aws_route53_zone.k8s-virginia-eureka-software.name_servers.0}",
    "${aws_route53_zone.k8s-virginia-eureka-software.name_servers.1}",
    "${aws_route53_zone.k8s-virginia-eureka-software.name_servers.2}",
    "${aws_route53_zone.k8s-virginia-eureka-software.name_servers.3}",
   ]
}

# bucket for storing KOPS cluster state info
resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.name}-terraform-state-store"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags {
    Name        = "${var.name}-${var.env}-terraform-state-store"
    Infra       = "${var.name}"
    Environment = "${var.env}"
    Terraformed = "true"
  }
}
