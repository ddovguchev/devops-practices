variable "vpc_id" {
  type = string
}

variable "allocated_storage" {
  description = "The allocated storage in gibibytes"
  type        = number
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD)"
  type        = string
}

variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "subnet_ids" {
  description = "A list of VPC subnet IDs"
  type        = list(string)
}

variable "username" {
  description = "Username for the master DB user"
  type        = string
}

variable "password" {
  description = "Password for the master DB user"
  type        = string
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed to connect to the RDS instance"
  type        = list(string)
}

variable "port" {
  description = "The port on which the RDS instance accepts connections"
  type        = number
  default     = 5432
}

variable "workspace" {
  type        = string
  default     = ""
}


