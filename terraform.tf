variable "aws-profile" {
  description = "AWS Profile Name"
}
variable "public-key" {
  description = "SSH Public key used to access nginx EC2 Server"  
}

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
