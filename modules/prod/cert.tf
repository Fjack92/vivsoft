## Hosted zone for acm reference
resource "aws_route53_zone" "prod" {
    name = "website.com"
}

## Create TLS Cert for Application load balancer
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "tls_cert" {
  key_algorithm   = "RSA"
  private_key_pem = tls_private_key.key.private_key_pem

  subject {
    common_name  = "website.com"
    organization = "Site Reliability Organization"
  }

  validity_period_hours = 12

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
}

## Use TLS from above to create cert through ACM
resource "aws_acm_certificate" "cert" {
  private_key      = tls_private_key.key.private_key_pem
  certificate_body = tls_self_signed_cert.tls_cert.cert_pem
}

## Create record for ACM cert validation
resource "aws_route53_record" "record" {
  for_each = {
    for dvo in aws_acm_certificate.example.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.prod.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.record : record.fqdn]
}