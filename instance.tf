data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [var.instance_detail["owner"]]
  filter {
    name   = "name"
    values = [var.instance_detail["image_name"]]
  }
  filter {
    name   = "virtualization-type"
    values = [var.instance_detail["virtualization_type"]]
  }
  filter {
    name   = "root-device-type"
    values = [var.instance_detail["root_device_type"]]
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_detail["instance_type"]
  key_name               = aws_key_pair.web_server_kp.key_name
  vpc_security_group_ids = [aws_security_group.web_server_security_group.id]
  tags = {
    Name = "${var.instance_detail["tag_name"]}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update && sudo apt-get install -y nginx && sudo systemctl start nginx && sudo systemctl enable nginx ",
    ]
  }

  provisioner "local-exec" {
    command = "echo 'Instance with ID: ${self.id}, IP: ${self.public_ip}, and Name: ${self.tags["Name"]} created on ${timestamp()}' >> instance.log"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.private_key_path}")
    host        = self.public_ip
  }

}
