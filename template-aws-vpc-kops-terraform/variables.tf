# AWS CLI Profile to use
variable "aws_profile" {
	default = "terraform-kmcgarry"
	#default = "eureka-terraform"
}

variable "name" {
  default = "popularnoise.com"
}

variable "region" {
  default = "us-east-1"
}

variable "azs" {
  default = ["us-east-1a", "us-east-1c", "us-east-1d"]
  type    = "list"
}

variable "env" {
  default = "staging01"
}

variable "vpc_cidr" {
  default = "10.20.0.0/16"
}

