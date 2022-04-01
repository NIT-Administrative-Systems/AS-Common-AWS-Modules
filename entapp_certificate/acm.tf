resource "aws_acm_certificate" "certificate_request" {
  domain_name               = var.hostnames[0]
  subject_alternative_names = slice(var.hostnames, 1, length(var.hostnames))
  validation_method         = "DNS"

  tags = {
    terraform = "true"
  }

  lifecycle {
    create_before_destroy = true
  }
}

