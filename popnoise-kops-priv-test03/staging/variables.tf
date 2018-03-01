# AWS CLI Profile to use
variable "aws_profile" {
	#default = "terraform-kmcgarry"
	default = "eureka-terraform"
}

variable "name" {
  default = "k8s-virginia.eureka.software"
}

variable "region" {
  default = "us-east-1"
}


# NEED TO MAKE THIS DYNAMIC
variable "azs" {
  default = ["us-east-1a", "us-east-1c", "us-east-1d"]
  type    = "list"
}

variable "env" {
  default = "staging03"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

