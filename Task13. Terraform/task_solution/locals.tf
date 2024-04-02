locals {
  vpc_cidr_block = "10.0.0.0/16"
  public_subnets_cidr_blocks = {
    bastion_host : {
      cidr : "10.0.1.0/24",
      az : "1"
    }
  }
  private_subnets_cidr_blocks = {
    nginx_host : {
      cidr : "10.0.2.0/24",
      az : "2"
    },
    rds1 : {
      cidr : "10.0.4.0/24",
    az : "1" },
    rds2 : {
      cidr : "10.0.6.0/24",
      az : "2"
    }
  }

  servers_config = {
    bastion_host = {
      sg_config = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      ]
      server_config = {
        ami           = data.aws_ami.ubuntu.id
        instance_type = "t2.micro"
        tags = {
          "Name" = "${terraform.workspace}-Bastion-host"
        }
        subnet_id = module.vpc_creator.public_subnets.bastion_host.id
        key_name  = aws_key_pair.bastion.key_name
        user_data = false
        isPublic  = true
      }
    },
    private_ec2 = {
      sg_config = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = [module.vpc_creator.public_subnets.bastion_host.cidr]
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = [module.vpc_creator.public_subnets.bastion_host.cidr]
        }
      ]
      server_config = {
        ami           = data.aws_ami.ubuntu.id
        instance_type = "t2.micro"
        tags = {
          "Name" = "${terraform.workspace}-Nginx-host",
        }
        subnet_id = module.vpc_creator.private_subnets.nginx_host.id
        key_name  = aws_key_pair.private_es2.key_name
        user_data = file("${path.module}/bootstrapping/nginx_install.sh")
        isPublic  = false
      }
    }
  }
}