resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  tags {
  	Name = "test_server"
  	role = "Docker-Worker"
  }

  root_block_device {
    volume_size = 16
    volume_type = "gp2"
    delete_on_termination = true
  }

  # the VPC Subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # static Private IP Address. For EIP, see resource section below
  # private_ip = "x.x.x.x"  # no mask required

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ports.id}"]  # notice this is a list, can assign multiple SGs to this instance

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

  # role to be able to work with s3 bucket
  iam_instance_profile = "${aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name}"

  # For EBS block device naming see here: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html
  # TL;DR /dev/sd[f-p]
  # TL;DR for most linux systems the device name for /dev/sdg will be /dev/xvdg.

  # Run the attach_ebs.sh file as part of startup
  # user_data = "${file("./scripts/disk_finish.sh")}"
}

# Assigning a static EIP which overrides the dynamic public ip allocated
resource "aws_eip" "example-eip"{
	instance = "${aws_instance.example.id}"
	#allow_reassociation = true
	vpc = true
}


# this block creates a volume in the same AZ as the instance above
#resource "aws_ebs_volume" "example-data01-volume" {
#  availability_zone = "${aws_instance.example.availability_zone}"
#  type              = "gp2"
#  size              = 25
#  tags {
#        Name = "extra data volume"
#        Mount_Point = "/data"
#    }
#}

# this block attaches the volume to the instance and then performs formatting and mounting
	# running into issues with the provisioner
	# either fix here or run via ansible
#resource "aws_volume_attachment" "example-data01-volume-attachment" {
#  device_name = "/dev/sdg"
#  instance_id = "${aws_instance.example.id}"
#  volume_id   = "${aws_ebs_volume.example-data01-volume.id}"
#  skip_destroy = true  # detaches volume but doesn't destroy it
#  provisioner "remote-exec" {
#    script = "${path.root}/scripts/disk_finish.sh"
#    connection {
#      type = "ssh"
#      user = "ec2-user"
#      # private_key = "${file("*.pem")}"
#      private_key = "${file(var.PATH_TO_PRIVATE_KEY)}"
#      timeout = "2m"
#      agent = false
#      }
# }
#}



