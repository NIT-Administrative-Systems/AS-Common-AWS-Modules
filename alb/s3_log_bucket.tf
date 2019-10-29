resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.account_label}-alb-logs"
  acl    = "private"

  tags {
    SharedResource = true
    Environment    = "${var.environment}"
  }
}
data "aws_s3_policy_document" "alb_writes_to_bucket" {
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = ["${aws_s3_bucket.alb_logs.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = "${aws_s3_bucket.alb_logs.id}"
  policy = "${data.aws_s3_policy_document.alb_writes_to_bucket.json}"

  tags {
    SharedResource = true
  }
}
