## 4. EC2 Security Group
resource "aws_security_group" "ec2_sg" {
  name = "ec2_security_group"
  description = "Allows inbound traffic from load balancer and mysql server"
  vpc_id = aws_vpc.main.id

  ingress {
      description = "Allow traffic from load balancer on port 8000"
      from_port = 8000
      to_port = 8000
      cidr_block = aws_vpc.main.cidr_block
  }

  ingress {
      description = "Allow inbound traffic from RDS"
      from_port = 3306
      to_port = 3306
      cidr_block = aws_vpc.main.cidr_block
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

## 5. EC2 in a Private Subnet

## Find latest AWS AMI of Ubuntu 20.04
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.ec2_sg.id ]
  subnet_id = aws_subnet.private.id

  tags = {
    Name = "Web Server"
  }
}