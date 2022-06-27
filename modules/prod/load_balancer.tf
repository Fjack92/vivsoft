## 1. S3 Bucket with SSE Enabled.
resource "aws_s3_bucket" "bucket" {
 bucket = "Application-Load-Balancer-Logs-Bucket"

 tags = {
   Name = "Application Load Balancer Logs Bucket"
   Environment = "Prod"
 }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse-config" {
  bucket = aws_s3_bucket.bucket.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}

## Load Balancer security group
resource "aws_security_group" "lb_sg" {
  name        = "loadbalancer_security_group"
  description = "Only allows access to load balancer from IP of applicant"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "Allow access over 443 from my ip"
    from_port        = 443
    to_port          = 443
    protocol         = "ssl"
    cidr_block      = "71.208.152.214/32"
  }

  ingress {
    description      = "Allow access over 80 from my ip"
    from_port        = 80
    to_port          = 80
    protocol         = "ssl"
    cidr_blocks      = "71.208.152.214/32"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

## Create Application Load Balancer
resource "aws_elb" "web_server_lb" {
  name               = "Web-Server-LB"
  subnets = [ aws_subnet.private.id ]
  security_groups = [ aws_security_group.lb_sg.id ]

  access_logs {
    bucket        = aws_s3_bucket.bucket.bucket
    bucket_prefix = "lb_logs"
    interval      = 60
  }

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port      = 8000
    instance_protocol  = "http"
    lb_port            = 443
    lb_protocol        = "https"
    ssl_certificate_id = aws_acm_certificate.cert.id
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.web_server.id]
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "Web-Server-Load-Balancer"
  }
}