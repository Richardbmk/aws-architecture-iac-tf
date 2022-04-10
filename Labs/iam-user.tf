resource "aws_iam_user" "user" {
  name = "rboriba"
  path = "/"
}

resource "aws_iam_access_key" "user_key" {
  user = aws_iam_user.user.name
}

resource "aws_iam_user_policy_attachment" "attachment" {
  user       = aws_iam_user.user.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_secretsmanager_secret" "user_secret" {
  name = "rboriba_access"
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id     = aws_secretsmanager_secret.user_secret.id
  secret_string = <<EOF
   {
    "username": "${aws_iam_user.user.name}",
    "Access_key_id": "${aws_iam_access_key.user_key.id}",
    "Access_key_secret": "${aws_iam_access_key.user_key.secret}"
   }
EOF
}


output "Access_key_id" {
  value = aws_iam_access_key.user_key.id
}


output "Access_key_secret" {
  value     = aws_iam_access_key.user_key.secret
  sensitive = true
}