resource "aws_iam_group" "devops" {
  name = "devops"
}

resource "aws_iam_group" "security" {
  name = "security"
}

resource "aws_iam_group" "network" {
  name = "network"
}

resource "aws_iam_group_membership" "devops_team" {
  name = "devops_team"

  users = [
    module.iam_user_devops_john.iam_user_name
  ]

  group = aws_iam_group.devops.name
}

resource "aws_iam_group_membership" "security_team" {
  name = "security_team"

  users = [
    module.iam_user_security_jane.iam_user_name
  ]

  group = aws_iam_group.security.name
}

resource "aws_iam_group_membership" "network_team" {
  name = "network_team"

  users = [
    module.iam_user_network_tom.iam_user_name
  ]

  group = aws_iam_group.network.name
}