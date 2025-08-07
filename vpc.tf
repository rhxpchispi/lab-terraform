
#En este recurso, crearemos una VPC, una sección privada de la nube donde crearemos
#nuestros recursos

resource "aws_vpc" "laboratorio" {
  cidr_block = "10.0.0.0/16"
}

#Dentro de la VPC, creamos una subnet, la cual es una sección de la VPC con una zona
# asignada para crear los recursos en dicha zona y en dicha red 

resource "aws_subnet" "subnet-1" {
  cidr_block              = "10.0.1.0/24"
  vpc_id                  = aws_vpc.laboratorio.id
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"
}

#Para poder acceder desde internet a nuestra red privada, necesitamos un recurso 
#de tipo Internet Gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.laboratorio.id
}

#Además, necesitamos crear una tabla de ruteo, donde configuramos la ruta para
# acceder a internet desde nuestra red privada 

resource "aws_route_table" "prod-public-crt" {
  vpc_id = aws_vpc.laboratorio.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Luego, asociamos la tabla de ruteo recién creada con la subnet donde crearemos 
#nuestra máquina virtual 

resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-public-crt.id
}
