instance_detail = {
  instance_type       = "t2.micro"
  tag_name            = "web_server"
  owner               = "483285841698"
  image_name          = "ubuntu-2404-standard-*"
  virtualization_type = "hvm"
  root_device_type    = "ebs"
  region              = "us-east-1"
}

instance_kp = {
  key_name = "web_server_key"
}

instance_security_group = {
  name        = "web_server_security_group"
  description = "Security group for web server managed by Terraform"
}

security_group_rules = {
  http = {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 80
    ip_protocol = "tcp"
    to_port     = 80
    description = "Allow HTTP"
  },
  ssh = {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
    description = "Allow SSH"
  },
  https = {
    cidr_ipv4   = "0.0.0.0/0"
    from_port   = 443
    ip_protocol = "tcp"
    to_port     = 443
    description = "Allow HTTPS"
  }
}


public_key_path  = "~/.ssh/id_rsa_tf.pub"
private_key_path = "~/.ssh/id_rsa_tf"