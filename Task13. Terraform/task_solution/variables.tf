variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}

variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region"
}

variable "db_user" {
  type        = string
  description = "User for postgresql"
}

variable "db_pass" {
  type        = string
  description = "Password for postgresql"
}
