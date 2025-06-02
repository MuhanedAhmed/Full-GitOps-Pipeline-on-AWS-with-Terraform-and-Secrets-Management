# -------------------------------------------------------------- #
# -------------------- EC2 Module Variables -------------------- #
# -------------------------------------------------------------- #

variable "instances" {
  type = map(object({
    instance_subnet_id  = string
    instance_private_ip = string
    security_group_ids  = list(string)
    has_public_ip       = optional(bool, false)
    user_data           = optional(string)
    instance_profile    = optional(string)
  }))

  description = "Map of EC2 instance configurations"
}

variable "instance_key_pair" {
  type        = string
  description = "The key-pair used to connect to the instance"
}
