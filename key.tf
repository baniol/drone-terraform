resource "aws_key_pair" "dronekeypair" {
  key_name   = "dronekeypair"
  public_key = "${file("${var.path_to_public_key}")}"
}
