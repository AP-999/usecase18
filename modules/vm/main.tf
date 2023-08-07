resource "aws_instance" "vm" {
  for_each      = var.instances
  ami           = var.ami
  instance_type = "t2.micro"
  subnet_id     = each.value.subnet_id

  tags = {
    Name = each.value.name
  }
}
