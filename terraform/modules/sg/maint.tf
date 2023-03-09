# SECURITY GROUP RESOURCE
resource "aws_security_group" "ec2_default_rules" {
  name        = "allow_connection_to_instance"
  vpc_id      = var.vpc_id

  dynamic ingress {
    for_each = var.ec2_ingress_ports_default
    content {
        description      = ingress.value
        from_port        = ingress.key
        to_port          = ingress.key
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}