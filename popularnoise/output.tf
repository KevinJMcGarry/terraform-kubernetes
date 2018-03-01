# outputs the instances public ip address
output "EC2 Instance dynamic public ip" {
  value = "${aws_instance.example.public_ip}"
}

output "EC2 Instance static (EIP) public ip" {
  value = "${aws_eip.example-eip.public_ip}"
}

output "NAT static (EIP) public ip" {
  value = "${aws_eip.nat.public_ip}"
}

#output "ns-servers" {
#   value = "${aws_route53_zone.k8s-ohio-popularnoise-com.name_servers}"
#}