
output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC id"
}

output "public_subnet_id" {
  value       = aws_subnet.public-subnet.id
  description = "IDs of the public subnets"
}