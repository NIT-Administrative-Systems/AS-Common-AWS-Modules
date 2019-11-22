output "team_sns_topics" {
  value = "${zipmap(keys(var.teams), list(aws_sns_topic.opsgenie_topic.*.arn))}"
}
