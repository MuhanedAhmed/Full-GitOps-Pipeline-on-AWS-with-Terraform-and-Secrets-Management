# -------------------------------------------------------------- #
# -------------- Secrets Manager Module Variables -------------- #
# -------------------------------------------------------------- #

variable "database_username" {
  description = "The name of the database"
  type        = string
}

variable "database_password" {
  description = "The password for the database"
  type        = string
}

variable "git_username" {
  description = "The name of the github user"
  type        = string
}

variable "git_password" {
  description = "The password for the github user"
  type        = string
}