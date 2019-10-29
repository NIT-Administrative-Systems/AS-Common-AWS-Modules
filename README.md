# Common AWS Modules for Admin Systems
This contains common terraform modules for Admin Systems AWS accounts.

This repository is not intended to be deployable or a template. Think of it as an abstract class; it has unimplemented methods that you need to fill in.

These modules target Terraform 0.10.x, which is the version deployed across our Jenkins fleet.

## Available Modules
You can pick and choose which modules you use by extending them in your project. Here are the available modules:

- [Application Load Balancer](./alb)