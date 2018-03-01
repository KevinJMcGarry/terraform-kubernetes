resource "aws_s3_bucket" "chaka_de_foo_bucket" {
    bucket = "mybucket-chakadefoo"
    acl = "private"

    tags {
        Name = "mybucket-chakadefoo"
    }
}

# first line, 2nd string is just a descriptor of the bucket
# second line is the actual bucket name that must be unique in all of s3



# terraform state file setup
# create an S3 bucket to store the state file in
#resource "aws_s3_bucket" "popularnoise-terraform-state-storage-s3" {
#    bucket = "popularnoise-terraform-remote-state-storage"
# 
#    versioning {
#      enabled = true
#    }
# 
#    lifecycle {
#      prevent_destroy = true
#    }
# 
#    tags {
#      Name = "S3 Remote Terraform State Store"
#    }      
#}