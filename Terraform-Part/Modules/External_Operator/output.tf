output "database_username_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.database_username.arn
}

output "database_password_arn" {
  description = "The ARN of the secret"
  value       = aws_secretsmanager_secret.database_password.arn
}