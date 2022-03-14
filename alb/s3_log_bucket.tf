resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.account_label}-alb-logs"

  tags = {
    SharedResource = true
  }
}


resource "aws_s3_bucket_acl" "alb_log_bucket_acl" {
  bucket = aws_s3_bucket.alb_logs.id
  acl    = "private"
}

# Needed for the ALB -> S3 policy, so the special AWS-controlled accounts
# can write logs to our bucket. It's weird, but that's how it works.
data "aws_elb_service_account" "alb_log_delivery" {}


data "aws_iam_policy_document" "alb_writes_to_bucket" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
      "s3:GetBucketAcl"
    ]

    # Needs access to both the objects (/*) and the bucket itself
    resources = ["${aws_s3_bucket.alb_logs.arn}/*", aws_s3_bucket.alb_logs.arn]
  }

  statement {
    effect = "Allow"

    principals {
      type = "AWS"
      identifiers = [data.aws_elb_service_account.alb_log_delivery.arn]
    }

    actions = [
      "s3:PutObject"
    ]

    resources = ["${aws_s3_bucket.alb_logs.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "alb_logs" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.alb_writes_to_bucket.json
}

