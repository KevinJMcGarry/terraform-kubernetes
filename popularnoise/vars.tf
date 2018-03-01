variable "AWS_REGION" {
  default = "us-east-2"
}

# default = "eureka-terraform"
variable "aws_profile" {
	default = "terraform-kmcgarry"
}

variable "AMIS" {
	 type = "map"
	 default = {
	  us-west-1 = "us-west-1"
	  us-west-2 = "us-west-2"
	  us-east-1 = "us-east-1"
	  us-east-2 = "ami-f63b1193"
     }
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/Users/kevinmcgarry/.ssh/mykey01"
}
variable "PATH_TO_PUBLIC_KEY" {
  default = "/Users/kevinmcgarry/.ssh/mykey01.pub"
}