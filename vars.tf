variable "amis" {
  type = "map"

  default = {
      "sa-east-1" = "ami-0c3c87b7d583d618f"
      "us-east-2" = "ami-0a0ad6b70e61be944"
  }
}

variable "cidrs_acesso_remoto" {
  type = "list"
  default = ["ip"] # ips externos de acesso
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "aws-terraform"
}