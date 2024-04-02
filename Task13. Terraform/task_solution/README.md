## Terrafor task

---
```bash
#before start
terraform workspace new task13-terraform && \
 terraform init && \
 terraform apply -auto-approve 
```


![infra.png](assets%2Finfra.png)

### Модуль EC2

* Создает n-e количество ec2
* Создает SG, для этих ec2 инстансов

Просит на вход:
```hcl
variable "servers_config" {
  description = "Configuration for servers"
  type = map(object({
    sg_config     = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
    }))
    server_config = object({
      ami           = string
      instance_type = string
      tags          = map(string)
      subnet_id     = string
      key_name      = optional(string)
      user_data     = optional(string)
      isPublic      = bool
    })
  }))
}

variable "vpc_id" {
   description = "Default VPC name"
   type = string
}
```
### На выходе отдает:

![ec2_module.png](assets%2Fec2_module.png)

---

### Модуль VPC

* Создает VPC
* Создает необходимое количество subnets и прикрепляет из к необходимой az
* Создает IGW, атачит его к публичным сабнетам

Просит на вход:
```hcl
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
}

variable "public_subnets_cidr_blocks" {
  description = "A list of CIDR blocks and az for public subnets"
  type        = map(object({
    cidr = string
    az   = string
  }))
}

variable "private_subnets_cidr_blocks" {
  description = "A list of CIDR blocks and az for public subnets"
  type        = map(object({
    cidr = string
    az   = string
  }))
}

variable "create_igw" {
  description = "Set to true to create an Internet Gateway"
  type        = bool
}

variable "workspace" {
  type        = string
  default     = ""
}

variable "aws_availability_zones" {
  type = list(string)
}

```
### На выходе отдает:
![vpc_module.png](assets%2Fvpc_module.png)

---