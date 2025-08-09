#En este caso para facilidad, le decimos a Terraform que luego de crear el código nos
# devuelva la IP pública de la instancia para poder conectarnos 

output "instance_ip" {
  description = "The public ip for ssh access"
  value       = aws_instance.instancia.public_ip
}
