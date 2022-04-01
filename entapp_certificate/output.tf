output "certificate_arn" {
  value       = aws_acm_certificate.certificate_request.arn
  description = "ARN for the requested certificate"
}

