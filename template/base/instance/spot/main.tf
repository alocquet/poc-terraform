variable "instance-type" {
  description = "The server instance type"  
}
variable "project-name" {
  description = "The project name"
}
variable "instance-name" {
  description = "The instance name"
}
variable "public-key" {
  description = "SSH Public key used to access nginx EC2 Server"
}
variable "os-name" {
  description = "OS Name"
}

module "vpc" {
  source = "../vpc"
  project-name = "${var.project-name}"
  instance-name = "${var.instance-name}"
  public-key = "${var.public-key}"
}
module "ami-search" {
  source = "../ami-search"
  os-name = "${var.os-name}"
}

resource "aws_spot_instance_request" "vm" {
  ami           = "${module.ami-search.ami-id}"
  instance_type = "${var.instance-type}"
  key_name    	= "${var.project-name}-${var.instance-name}-key"
  spot_price    = "0.03"

  vpc_security_group_ids = [ "${module.vpc.sg-id}" ]

  user_data     = <<-EOF
              #!/bin/bash
              yum update -y
              EOF

  tags          = { 
    Project = "${var.project-name}"
    Instance = "${var.project-name}-${var.instance-name}"
    Name = "${var.project-name}-${var.instance-name}"
  }
}
