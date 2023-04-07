#this file consists of code for instances and sg
provider "aws" {
region = "ap-south-1"
access_key = "AKIAXQEIT3AEX7S7TYJT"
secret_key = "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"
}

resource "aws_instance" "one" {
  ami             = "ami-0d1ecaad2613d97c3"
  instance_type   = "t2.micro"
  key_name        = "keypairfordemo"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my app created by terraform infrastructurte by vijay server-1" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-0d1ecaad2613d97c3"
  instance_type   = "t2.micro"
  key_name        = "keypairfordemo"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "hai all this is my website created by terraform infrastructurte by vijay server-2" > /var/www/html/index.html
EOF
  tags = {
    Name = "web-server-2"
  }
}

resource "aws_instance" "three" {
  ami             = "ami-0d1ecaad2613d97c3"
  instance_type   = "t2.micro"
  key_name        = "keypairfordemo"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  tags = {
    Name = "app-server-1"
  }
}

resource "aws_instance" "four" {
  ami             = "ami-0d1ecaad2613d97c3"
  instance_type   = "t2.micro"
  key_name        = "keypairfordemo"
  vpc_security_group_ids = [aws_security_group.five.id]
  availability_zone = "ap-south-1b"
  tags = {
    Name = "app-server-2"
  }
}

resource "aws_security_group" "five" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "six" {
  bucket = "vijayterra77889900"
}

resource "aws_iam_user" "seven" {
name = "vijayuser" 
}

resource "aws_ebs_volume" "eight" {
 availability_zone = "ap-south-1b"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
