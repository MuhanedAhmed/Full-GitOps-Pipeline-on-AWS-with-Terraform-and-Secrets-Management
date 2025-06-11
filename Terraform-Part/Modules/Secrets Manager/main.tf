# ------------------------------------------------------------------------
# Creating Credentials for MongoDB
# ------------------------------------------------------------------------

resource "aws_secretsmanager_secret" "mongo_creds" {
  name                           = "mongodb/creds"
  recovery_window_in_days        = 0
  force_overwrite_replica_secret = true
}

resource "aws_secretsmanager_secret_version" "database_username_version" {
  secret_id = aws_secretsmanager_secret.mongo_creds.id
  secret_string = jsonencode({
    username = var.database_username
    password = var.database_password
  })
}