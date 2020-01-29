variable "hostnames" {
  description = "The domain name(s) that the site will be accessible as, e.g. our-register-dev.northwestern.edu. A SAN cert will be generated if you specify more than one hostname, with the first as the common name."
  type        = list(string)
}

