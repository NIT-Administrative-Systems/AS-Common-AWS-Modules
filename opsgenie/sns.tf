resource "aws_sns_topic" "opsgenie_topic" {
  for_each = var.teams

  name = "OpsGenie-${each.key}"

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false
  }
}
EOF

}

resource "aws_sns_topic_subscription" "opsgenie_integration" {
  for_each = var.teams

  topic_arn              = aws_sns_topic.opsgenie_topic[each.key].arn
  protocol               = "https"
  endpoint               = each.value
  endpoint_auto_confirms = true
}

