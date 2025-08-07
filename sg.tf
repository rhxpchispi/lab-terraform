
#Seguimos con los recursos de red/seguridad, donde en este caso asociamos un recurso
# de tipo security group a nuestra vpc el cual permite acceder al puerto 22 desde cualquier ip (0.0.0.0/0, en caso de querer hacer el acceso más restringido, pueden cambiarlo por la IP pública de su casa, tener en cuenta que esta IP es dinamica) 

resource "aws_security_group" "ssh" {
  name   = "allow_ssh"
  vpc_id = aws_vpc.laboratorio.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
