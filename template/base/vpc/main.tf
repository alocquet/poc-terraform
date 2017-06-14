variable "project-name" {
  description = "The project name"
}
variable "instance-name" {
  description = "The instance name"
}
variable "public-key" {
  description = "SSH Public key used to access nginx EC2 Server"
}
resource "aws_security_group" "vm-sg" {
  name        = "${var.project-name}-${var.instance-name}-sg"
  description = "Allow ssh inbound traffic and all outbund traffic"

  ingress {
    from_port   = 22
    to_port     = 22
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
    Project = "${var.project-name}"   
    Instance = "${var.project-name}-${var.instance-name}"
    Name = "${var.project-name}-${var.instance-name}-sg"
  }
}
resource "aws_key_pair" "vm-keypair" {
  key_name   = "${var.project-name}-${var.instance-name}-key"
  public_key = "${var.public-key}"
}
output "sg-id" {
  value = "${aws_security_group.vm-sg.id}"
}