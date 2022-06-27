## 2. RDS Security Group
resource "aws_db_security_group" "rds_sg" {
  name = "rds_sg"

  ingress {
    cidr = var.private_subnet_cidr
    from_port = 3306
    to_port = 3306
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

## 3. MySQL RDS in a Private subnet
resource "aws_db_subnet_group" "private_db_subnet" {
  name       = "Private"
  subnet_ids = [ aws_subnet.private.id ]

  tags = {
    Name = "Private"
  }
}

resource "aws_db_instance" "MYSQL_DB" {
  allocated_storage = 10
  engine = "mysql"
  instance_class = "db.t3.micro"
  db_name = "DATABASE NAME"
  username = var.rds_username
  password = var.rds_password
  vpc_security_group_ids = [ aws_db_security_group.rds_sg.id ]
  db_subnet_group_name = aws_db_subnet_group.private_db_subnet.name
}