variable "instance-type" {
  description = "The server instance type"  
}
variable "project-name" {
  description = "The project name"  
}
data "aws_ami" "amazon-linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_security_group" "nginx-sg" {
  name        = "${var.project-name}-sg"
  description = "Allow ssh and http inbound traffic and all outbund traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags          = { 
    App = "${var.project-name}-nginx" 
    Name = "${var.project-name}-nginx-sg"
  }
}

resource "aws_instance" "nginx" {
  ami           = "${data.aws_ami.amazon-linux.id}"
  instance_type = "${var.instance-type}"
  key_name    	= "${var.project-name}-key"

  vpc_security_group_ids = [ "${aws_security_group.nginx-sg.id}" ]

  user_data     = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              chkconfig nginx on
              service nginx start
              EOF

  tags          = { 
    App = "${var.project-name}-nginx" 
    Name = "${var.project-name}-nginx"
  }
}
