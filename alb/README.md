# Application Load Balancer
This is a common ALB component. 

It doesn't do much right now, but we may end up integrating cool things like the WAF into it at a later date. Since this is a centrally-controlled module, it will be easy for us to deploy those sorts of changes across the fleet.

Once your ALB is created, you will need to create a listener for your application, and then as many target groups as you have per environment. For example, a microservice in the non-prod account will have one listener, a dev target group, and a prod target group.

[Listeners](https://www.terraform.io/docs/providers/aws/d/lb_listener.html) and [target groups](aws_lb_listener) are the application IaC's responsibility to create. This module exports the ALB's ARN, which is what you'll need to create them.

## Example Usage
**@TODO**