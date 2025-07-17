resource "aws_instance" "hello_ec2" {
  ami                     = var.ami
  instance_type           = var.instance_type
  vpc_security_group_ids  = var.security_group_ids
  key_name                = var.key_name
  subnet_id               = var.subnet_id

  provisioner "remote-exec" {
    inline = [
      "sudo dnf update -y",
      "curl -sL https://rpm.nodesource.com/setup_22.x | sudo bash -",
      "sudo dnf install -y git nodejs"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file(var.private_key_path)
      host        = self.public_ip
    }
  }

  tags = {
    Name = var.name
  }
}

