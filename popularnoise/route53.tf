# this creates a completely new zone, unless you use terraform import
# terraform import updates your state data (good idea to have that in S3)
# make sure you use the trailing . in the name before the import!!

# terraform import aws_route53_zone.popularnoise-com Z2NXJ40RLXM0QB

resource "aws_route53_zone" "popularnoise-com" {
  name = "popularnoise.com."
}

# K8S sub-domain for ohio region
resource "aws_route53_zone" "k8s-ohio-popularnoise-com" {
   name = "k8s-ohio.popularnoise.com"
#   parent_route53_zone = "${aws_route53_zone.popularnoise-com.zone_id}"
}

# below is for populating sub-domain NS records into the parent zone
resource "aws_route53_record" "k8s-ohio-popularnoise-com-ns" {
   zone_id = "${aws_route53_zone.popularnoise-com.zone_id}"
   name = "k8s-ohio.popularnoise.com"
   type = "NS"
   ttl = "30"
   records = [
    "${aws_route53_zone.k8s-ohio-popularnoise-com.name_servers.0}",
    "${aws_route53_zone.k8s-ohio-popularnoise-com.name_servers.1}",
    "${aws_route53_zone.k8s-ohio-popularnoise-com.name_servers.2}",
    "${aws_route53_zone.k8s-ohio-popularnoise-com.name_servers.3}",
   ]
}


# test record in parent domain
resource "aws_route53_record" "server1-record" {
   zone_id = "${aws_route53_zone.popularnoise-com.zone_id}"
   name = "server1.popularnoise.com"
   type = "A"
   ttl = "300"
   records = ["1.2.3.5"]
#   records = ["${aws_eip.example-eip.public_ip}"]  # assigning an Elastic IP
}

# test record in sub domain
resource "aws_route53_record" "server2-record" {
   zone_id = "${aws_route53_zone.k8s-ohio-popularnoise-com.zone_id}"
   name = "server2.k8s-ohio.popularnoise.com"
   type = "A"
   ttl = "300"
   records = ["1.2.3.6"]
}