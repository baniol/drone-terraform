data "template_file" "server" {
  template = "${file("${path.module}/templates/server.tpl")}"

  vars {
    aws_region          = "${var.region}"
    drone_host          = "${format("%s://%s", "http", var.drone_host)}"
    drone_github_client = "${var.github_client}"
    drone_github_secret = "${var.github_secret}"
    drone_agent_host    = "${format("%s:%s", var.drone_host, "9000")}"
  }
}

resource "aws_autoscaling_group" "drone" {
  name                      = "asg-drone"
  max_size                  = "${var.max_size}"
  min_size                  = "${var.min_size}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = "${var.desired_capacity}"
  launch_configuration      = "${aws_launch_configuration.drone.name}"
  vpc_zone_identifier       = ["${aws_subnet.main-public-1.id}"]
}

resource "aws_iam_instance_profile" "default" {
  name = "drone-profile"
  role = "${aws_iam_role.drone_role.name}"
}

resource "aws_launch_configuration" "drone" {
  name_prefix          = "drone"
  image_id             = "${lookup(var.amis, var.region)}"
  instance_type        = "${var.instance_type}"
  key_name             = "${aws_key_pair.dronekeypair.key_name}"
  iam_instance_profile = "${aws_iam_instance_profile.default.arn}"

  security_groups = [
    "${aws_security_group.instance-sg.id}",
  ]

  user_data = "${data.template_file.server.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_drone" {
  autoscaling_group_name = "${aws_autoscaling_group.drone.id}"
  elb                    = "${aws_elb.elb.id}"
}

resource "aws_security_group" "instance-sg" {
  vpc_id      = "${aws_vpc.main.id}"
  name        = "instance-sg"
  description = "security group that allows ssh and and web all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}