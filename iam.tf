resource "aws_iam_policy" "allow-ecr" {
  name   = "allow-ecr"
  path   = "/"
  policy = "${data.aws_iam_policy_document.allow-ecr.json}"
}

data "aws_iam_policy_document" "allow-ecr" {
  statement {
    actions = [
      "ecr:*",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "instance-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "drone_role" {
  name               = "drone"
  description        = "allow drone to access aws resources"
  assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role.json}"
}

resource "aws_iam_role_policy_attachment" "drone_policy" {
  role       = "${aws_iam_role.drone_role.name}"
  policy_arn = "${aws_iam_policy.allow-ecr.arn}"
  depends_on = ["aws_iam_role.drone_role"]
}
