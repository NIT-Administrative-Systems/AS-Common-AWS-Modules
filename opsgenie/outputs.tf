output "team_sns_topics" {
  value = {
    for k, o in aws_sns_topic.opsgenie_topic:
    k => o.arn
  }
}

