# Common AWS Modules for Admin Systems
This contains common terraform modules for Admin Systems AWS accounts. These modules are *opinionated*, and will do things the way Admin Systems wants.

This repository is not intended to be deployable or a template. Think of it as an abstract class; it has unimplemented methods that you need to fill in.

These modules target Terraform 0.12.x.

## Available Modules
You can pick and choose which modules you use by extending them in your project. Here are the available modules:

- [Application Load Balancer](./alb)
- [Certificates for `entapp.northwestern.edu`](./entapp_certificate)
- [OpsGenie Integration for CloudWatch Alarms](./opsgenie)
- [Private Subnet Assignment](./private_subnet), mostly for use by the shared AWS account resource modules
