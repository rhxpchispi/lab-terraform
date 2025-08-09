
#Ya lista nuestra red, configuramos nuestra instancia 

resource "aws_instance" "instancia" {
  ami                         = "ami-004dac467bb041dc7"
  instance_type               = "t2.micro"
  key_name                    = "terraform_ec2_key"
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.ssh.id]

  tags = {
    Name     = "lab-educacionIT-dev"
    ambiente = "dev"
    cloud    = "AWS"
    region   = "us-east-1"
  }

  user_data = <<-EOL
  #!/bin/bash -xe

  # Install and configure Docker
  apt update
  apt install -y docker.io
  addgroup --system docker
  adduser ubuntu docker
  newgrp docker
  EOL

}

#Y por último, le decimos a la instancia que agregue nuestra llave pública de ssh 
#generada antes para poder conectarnos con la llave privada luego. 

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = file("terraform-ec2-key.pub")
}
