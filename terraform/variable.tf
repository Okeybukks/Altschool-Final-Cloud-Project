variable "region" {
  default = "us-east-1"
}

variable "ami" {
  type = map(string)

  default = {
    us-east-1 = "ami-00874d747dde814fa" # Ubuntu 20.04 x86
  }
}

variable "instance_type" {
  default = "t2.medium"
}