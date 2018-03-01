# this creates the Role allowing an ec2 instance to AssumeRole
resource "aws_iam_role" "s3-mybucket-role" {
    name = "s3-mybucket-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# this creates the Instance Profile - see prior notes on link between Roles, Profiles and Policies
resource "aws_iam_instance_profile" "s3-mybucket-role-instanceprofile" {
    name = "s3-mybucket-role"
    role = "${aws_iam_role.s3-mybucket-role.name}"
}

# this creates the Role Policy that dictates what permissions the EC2 instance will have on the bucket
resource "aws_iam_role_policy" "s3-mybucket-role-policy" {
    name = "s3-mybucket-role-policy"
    role = "${aws_iam_role.s3-mybucket-role.id}"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
              "s3:*"
            ],
            "Resource": [
              "arn:aws:s3:::mybucket-chakadefoo",
              "arn:aws:s3:::mybucket-chakadefoo/*"
            ]
        }
    ]
}
EOF
}

