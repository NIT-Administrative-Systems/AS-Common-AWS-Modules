# Private Subnets for us-east-2
This module creates private subnets in us-east-2 with routing back to the internet.

Since creating subnets, a route table, and the route table <-> subnet associations is rather verbose, this module serves to DRY out our most common IP allocation pattern.

Unlike the other private_subnet module, which is limited to 2 subnets and 2 availability zones, this will take in any number of both (i.e. 4 subnets and 4 availability zones). However, they are mapped together so you CANNOT do something like 3 subnets and 4 availability zones. Each list must be the same length.
