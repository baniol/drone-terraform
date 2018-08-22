resource "aws_route53_record" "root-record" {
  zone_id = "${var.zoneID}"
  name    = "${var.drone_host}"
  type    = "A"

  alias {
    name                   = "${aws_elb.elb.dns_name}"
    zone_id                = "${aws_elb.elb.zone_id}"
    evaluate_target_health = true
  }
}
