# backend for terraform state - s3 bucket.tf
# Remote state allows you to store the state file for a stack in s3 so it can be shared across ops teams/developers


terraform =  {
  backend "s3" {
  encrypt = "true"
  bucket = "popularnoise-terraform-remote-state-storage"
  key = "terraform.tfstate" # state file to be created on the s3 bucket
  profile = "terraform-kmcgarry"
  region = "us-east-2"
  }
}
# note you can't use vars to specify your aws profile to use