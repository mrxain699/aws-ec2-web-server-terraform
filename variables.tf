variable "instance_detail" {
  type = map(string)
}


variable "instance_kp" {
  type = map(string)
}

variable "instance_security_group" {
  type = map(string)
}

variable "security_group_rules" {
  type = map(object({
    cidr_ipv4   = string
    from_port   = number
    ip_protocol = string
    to_port     = number
    description = string
  }))

}

variable "public_key_path" {
  type = string
}

variable "private_key_path" {
  type = string
}