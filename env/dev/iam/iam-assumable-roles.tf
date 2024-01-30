provider "aws" {
  region = "eu-west-1"
}

######################
# IAM assumable roles
######################
module "iam_assumable_roles_billing" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_admin_role = false

  create_poweruser_role      = true
  poweruser_role_name        = "Billing-And-Support-Access"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]
  poweruser_role_requires_mfa = false

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}

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
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
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


######################################
# IAM assumable roles with self assume
######################################
module "iam_assumable_roles_with_self_assume" {
  source = "../../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_admin_role          = true
  allow_self_assume_role     = true
  create_poweruser_role      = true
  admin_role_name            = "Admin-Role-Name-Self-Assume"
  poweruser_role_name        = "Billing-And-Support-Access-Self-Assume"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]
  readonly_role_name         = "Read-Only-Role-Name-Self-Assume"

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}
