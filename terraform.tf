variable "aws-profile" {}
variable "public-key" {}

provider "aws" {
  region	= "eu-west-1"
  profile       = "${var.aws-profile}"
}

module "nginx" {
  source = "./template/nginx"
  instance-type = "t2.micro"
  project-name = "terraform"
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = "${var.public-key}"
}
