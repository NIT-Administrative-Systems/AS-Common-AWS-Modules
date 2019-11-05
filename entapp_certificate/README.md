# Certificate Requests
This is a common module to request a certificate for hosts under the `entapp.northwestern.edu` zone.

At this time, it's a pass-through to an ACM request resource. In future, ADO hopes to get this tied to the Infoblox so it will automatically make the validation DNS record.

## Example Usage
Create a module

```terraform
module "certificate" {
    // The double slash IS significant <https://www.terraform.io/docs/modules/sources.html#modules-in-package-sub-directories>
    source = "github.com/NIT-Administrative-Systems/AS-Common-AWS-Modules//host_with_cert"

    hostnames = ["docconvapi.entapp.northwestern.edu", "docconvapi-qa.entapp.northwestern.edu", "docconvapi-qa.entapp.northwestern.edu"]
}

resource "aws_cloudfront_distribution" "s3_distribution" {
    viewer_certificate {
        acm_certificate_arn = "${module.certificate.certificate_arn}"
    }

    // . . .
}
```