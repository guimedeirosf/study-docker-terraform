resource "aws_security_group" "permite_ssh_web" {
  name        = "permite_ssh_web"
  description = "Permite SSH e HTTP"

  ingress {

    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    }


}

locals {
  ami_lab3 = "ami-0a0d9cf81c479446a"
  servers  = ["Server 1", "Server 2", "Server 3"]
}

resource "aws_instance" "grmf_instance" {
  count = local.ami_lab3 == "ami-0a0d9cf81c479446a" ? 3 : 0
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.permite_ssh_web.id]

  key_name = "grmf-lab3"


  tags = {
    Name = "webserver-${count.index + 1}"
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install httpd -y
              sudo systemctl start httpd
              sudo systemctl enable httpd
              sudo bash -c 'echo "<h1>Bem-vindo ao ${local.servers[count.index]}</h1>" > /var/www/html/index.html'
              EOF


}
