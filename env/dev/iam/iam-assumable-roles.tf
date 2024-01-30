provider "aws" {
  region = "eu-west-1"
}

######################
# IAM assumable roles
######################

module "iam_assumable_roles_network" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:root",
    "arn:aws:iam::597947213367:user/emrah-iam-testing",
  ]

  trusted_role_services = [
    "eks.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Alexa-For-Business-Full-Access"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/NetworkAdministrator", "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"]
  poweruser_role_requires_mfa = false

}

module "iam_assumable_roles_dev" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:user/emrah-iam-testing-dev",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Readonly-Access-For-Devs"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::444469924026:policy/bucket_policy_list_get_location"]
  poweruser_role_requires_mfa = false

}

module "iam_assumable_roles_qa" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::597947213367:user/emrah-iam-testing-qa",
  ]

  trusted_role_services = [
    "ec2.amazonaws.com"
  ]

  create_poweruser_role      = true
  poweruser_role_name        = "Readonly-Access-For-QA"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess", "arn:aws:iam::aws:policy/AWSBackupOperatorAccess"]
  poweruser_role_requires_mfa = false

}

