# Private Subnets for us-east-2
This module creates a pair of private subnets in us-east-2 with routing back to the internet.

Since creating subnets, a route table, and the route table <-> subnet associations is rather verbose, this module serves to DRY out our most common IP allocation pattern.

