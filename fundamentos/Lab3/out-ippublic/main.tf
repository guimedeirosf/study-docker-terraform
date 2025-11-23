resource "aws_instance" "grmf_instance" {
  
  ami = "ami-0a0d9cf81c479446a"  
  
  instance_type = var.instance_type

  tags = {
    Name = "grmflab3-t1-terraform"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.grmf_instance.public_ip} > ip_grmf_instance.txt"
  }
}
