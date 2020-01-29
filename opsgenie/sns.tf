resource "aws_sns_topic" "opsgenie_topic" {
  count = length(var.teams)

  name = "OpsGenie-${element(keys(var.teams), count.index)}"

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
  count = length(var.teams)

  topic_arn              = element(aws_sns_topic.opsgenie_topic.*.arn, count.index)
  protocol               = "https"
  endpoint               = var.teams[element(keys(var.teams), count.index)]
  endpoint_auto_confirms = true
}

