variable "os-name" {
  description = "OS Name"
}
variable "ami-search" {
  type = "map"
  default = {
    windows = "Windows_Server-2016-English-Full-Base"
    suse = "suse-sles-12*hvm-ssd-x86_64"
    rhel = "RHEL-7.4*"
    linux = "amzn-ami-hvm-*-x86_64-gp2"
  }
}
data "aws_ami" "ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami-search[var.os-name]}"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon", "309956199498"]
}

output "ami-id" {
    value = "${data.aws_ami.ami.id}"
}