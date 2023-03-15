variable "ec2_ingress_ports_default" {
  description = "Allowed Ec2 ports"
  default     = {
    "22"  = "SSH to VPC"
    "443" = "HTTPS to VPC"
    "80" = "HTTP to VPC"
    "8080" = "Jenkins to VPC"
}
}

variable "vpc_id" {} 