provider "aws" {
  region = "eu-west-1"
}

######################
# IAM assumable roles
######################

module "iam_assumable_roles_network" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:user/network_tom",
  ]

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Network-Admins-Access-Role"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/NetworkAdministrator", "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"]
  poweruser_role_requires_mfa = false

}

module "iam_assumable_roles_security" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:user/security_jane",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Security-Admins-Access-Role"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/SecurityAudit", "arn:aws:iam::444469924026:policy/bucket_policy_list_get_location"]
  poweruser_role_requires_mfa = false

}

module "iam_assumable_roles_devops" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:user/devops_john",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Devops-Access-Role"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  poweruser_role_requires_mfa = false

}

