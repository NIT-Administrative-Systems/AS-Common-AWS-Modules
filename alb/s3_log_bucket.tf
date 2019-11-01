resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.account_label}-alb-logs"
  acl    = "private"

  tags = {
    SharedResource = true
  }
}
data "aws_iam_policy_document" "alb_writes_to_bucket" {
  statement {
    effect = "Allow"
    
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject"
    ]
    resources = ["${aws_s3_bucket.alb_logs.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = "${aws_s3_bucket.alb_logs.id}"
  policy = "${data.aws_iam_policy_document.alb_writes_to_bucket.json}"
}
