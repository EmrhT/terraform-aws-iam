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

resource "aws_iam_group_policy_attachment" "devops_team_attachment" {
  group      = aws_iam_group.devops.name
  policy_arn = module.iam_policy_from_data_source_assume_roles_from_444469924026.arn
}

resource "aws_iam_group_policy_attachment" "security_team_attachment" {
  group      = aws_iam_group.security.name
  policy_arn = module.iam_policy_from_data_source_assume_roles_from_444469924026.arn
}

resource "aws_iam_group_policy_attachment" "network_team_attachment" {
  group      = aws_iam_group.network.name
  policy_arn = module.iam_policy_from_data_source_assume_roles_from_444469924026.arn
}