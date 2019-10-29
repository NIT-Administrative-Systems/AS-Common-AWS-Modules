resource "aws_lb" "alb" {
  depends_on = ["aws_s3_bucket_policy.alb_logs"]

  name               = "${var.account_label}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.lb_security_group.id}"]
  subnets            = ["${var.subnets}"]

  access_logs {
    bucket  = "${aws_s3_bucket.alb_logs.id}"
    enabled = true
  }

  tags = {
    SharedResource = true
  }
}

resource "aws_security_group" "lb_security_group" {
  name        = "${var.account_label}-alb-security-group"
  description = "Allow inbound traffic to application load balancer"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
