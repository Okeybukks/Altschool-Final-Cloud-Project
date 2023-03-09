# PROVIDER FOR THE TERRAFORM RESOURCES.
provider "aws" {
  profile = "myprofile"
  region  = var.region
}

# VPC RESOURCE
module "vpc" {
  source = "./modules/vpc"
}

# SECURITY GROUP RESOURCE
module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# PUBLIC INSTANCE RESOURCE FOR JENKINS
resource "aws_instance" "public_server" {
  ami                         = lookup(var.ami, var.region)
  security_groups             = [module.sg.SG_id]
  subnet_id                   = module.vpc.public_subnet_id
  instance_type               = var.instance_type
  associate_public_ip_address = true

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = tls_private_key.pk.private_key_pem
    host     = self.public_ip
  }

  provisioner "file" {
    source="./packages.sh"
    destination="/tmp/packages.sh"
  }

  provisioner "remote-exec" {
    inline=[
    "chmod +x /tmp/packages.sh",
    "sudo /tmp/packages.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo echo '${self.public_ip}' >> /etc/ansible/hosts",
    ]
  }

  provisioner "local-exec" {

    command = "echo 'jenkins-server ansible_host=${self.public_ip}' ansible_ssh_user=ubuntu ansible_ssh_private_key_file=.aws/myKey.pem' >> ansible-folder/host-inventory"
  }
  tags = {
    Name : "public_server"
  }
  key_name = aws_key_pair.key-pair.id

  lifecycle {
    create_before_destroy = true
  }

}

# SECURITY KEY RESOURCE
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key-pair" {
  key_name   = "myKey"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > .aws-key/myKey.pem"
  }
}