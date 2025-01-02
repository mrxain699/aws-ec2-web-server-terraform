resource "aws_key_pair" "web_server_kp" {
  key_name   = var.instance_kp["key_name"]
  public_key = file("${var.public_key_path}")
}