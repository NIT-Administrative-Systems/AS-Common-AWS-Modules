resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.account_label}-alb-logs"
  acl    = "private"

  tags = {
    SharedResource = true
  }
}

# Needed for the ALB -> S3 policy so it can write logs
data "aws_organizations_organization" "account" {}

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
      identifiers = [aws_organizations_organization.account.arn]
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

