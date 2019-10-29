## Overview
<!-- A brief description of what the change is, how you achieved that, 
and why you are changing it. -->

## Checklist
- [ ] `terraform validate` <=0.11.x returns no errors (except maybe some vars w/out values)
- [ ] In a new module, the [provider version](https://www.terraform.io/docs/configuration/providers.html#version-provider-versions) is frozen
- [ ] Variables & outputs all have descriptions