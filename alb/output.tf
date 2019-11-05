output "lb_arn" {
  description = "Application load balancer ARN, for creating listeners/target groups."
  value       = "${aws_lb.alb.arn}"
}

output "lb_arn_suffix" {
  description = "ARN suffix, useful for setting up metrics and alarms in CloudWatch."
  value       = "${aws_lb.alb.arn_suffix}"
}

output "lb_hostname" {
  description = "The hostname for the load balancer. Application CNAMEs should point to this."
  value       = "${aws_lb.alb.dns_name}"
}

output "lb_security_group_id" {
  description = "The security group ID for the ALB -> your service. Necessary for things like ECS security policies."
  value = "${aws_security_group.lb_security_group.name}"
}