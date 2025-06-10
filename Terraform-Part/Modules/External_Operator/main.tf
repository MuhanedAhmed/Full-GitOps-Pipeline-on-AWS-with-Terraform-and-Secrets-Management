
resource "aws_secretsmanager_secret" "database_username" {
  name = var.database_username
}

resource "aws_secretsmanager_secret_version" "database_username_version" {
  secret_id     = aws_secretsmanager_secret.database_username.id
  secret_string = var.database_username
}



resource "aws_secretsmanager_secret" "database_password" {
  name = var.database_username
}

resource "aws_secretsmanager_secret_version" "database_password_version" {
  secret_id     = aws_secretsmanager_secret.database_password.id
  secret_string = var.database_username
}