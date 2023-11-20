provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "eu-central-1"
}
resource "aws_instance" "Jenkins-2" {
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Jenkins2.id]
  user_data                   = file("install_jenkins.sh")
  user_data_replace_on_change = true
  key_name                    = "for_ansib_jenx"
  ami = "ami-0d1ddd83282187d18"
  tags = {
    Name = "Jenkins-2"
    "ENV"    = "production"

  }
}
resource "aws_instance" "Ansible" {
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.Jenkins2.id]
  user_data                   = file("install_ansible.sh")
  user_data_replace_on_change = true
  key_name                    = "for_ansib_jenx"
  ami                         = "ami-0d1ddd83282187d18"
  tags                        = {
    Name  = "Ansible"
    "ENV" = "production"

  }
}

resource "aws_security_group" "Jenkins2" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  dynamic "ingress" {
    for_each = ["80", "443", "22", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_key_pair" "jenkins2_key" {
      key_name   = "for_ansib_jenx"
      public_key = ""

    }





