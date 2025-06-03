# --------------------------------------------------------------- #
# --------------------- VPC Module Variables -------------------- #
# --------------------------------------------------------------- #

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block to assign to the VPC"
}

variable "vpc_name" {
  type        = string
  description = "An optional name tag to assign to the VPC"
  default     = null
}

variable "public_subnets" {
  type = map(object({
    subnet_cidr = string
    subnet_az   = string
    tags        = map(string)
  }))
  description = "Map of public subnets with their CIDR blocks, availability zones and tags"
}

variable "private_subnets" {
  type = map(object({
    subnet_cidr = string
    subnet_az   = string
    tags        = map(string)
  }))
  description = "Map of private subnets with their CIDR blocks, availability zones and tags"
}