variable publickey {
  description = "SSH Public key used to access nginx EC2 Server"
}
/*variable "aws-profile" {
  description = "AWS Profile Name"
}
provider "aws" {
  profile = "${var.aws-profile}"
}*/
provider "aws" { 
  region	= "eu-west-1"
}

module "base" {
  /*source = "./template/base/instance/ondemand"*/
  source = "./template/base/instance/spot"
  /*instance-type = "t2.micro"*/
  instance-type = "m4.large"
  project-name = "ligoj"
  instance-name = "blog"
  os-name = "linux"
  public-key = "${var.publickey}"
}
