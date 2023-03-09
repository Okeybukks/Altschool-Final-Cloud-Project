variable "public-subnet" {
  default = [
    { tag = "public-subnet", cidr = "10.0.1.0/24", az = "us-east-1a" },
  ]
}