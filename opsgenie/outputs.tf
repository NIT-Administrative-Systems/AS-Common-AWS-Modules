output "team_sns_topics" {
  value = zipmap(keys(var.teams), aws_sns_topic.opsgenie_topic.*.arn)
}

