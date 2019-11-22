# OpsGenie Notifications from CloudWatch
This module will create Simple Notification Service (SNS) topics with an OpsGenie webhook subscription for multiple teams. It will output a map of team name => SNS topic ARN, which you can then use for CloudWatch alarms.

OpsGenie supports receiving messages from CloudWatch via SNS by way of their [CloudWatch integration](https://docs.opsgenie.com/docs/aws-cloudwatch-integration). Anybody on an OpsGenie team with the admin role (typically the team lead) can add the CloudWatch integration and retrieve the URL w/ API key that this module needs.

## Example Usage
**TODO**, example on how to access the remote state & get your SNS topic ARN
