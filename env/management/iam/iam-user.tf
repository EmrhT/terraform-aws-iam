provider "aws" {
  region = "eu-west-1"
}

#########################################
# IAM user, login profile and access key
#########################################
module "iam_user_devops_john" {
  source = "../../../modules/iam-user"

  name          = "devops_john"
  force_destroy = true

  
  # User "test" has uploaded his public key here - https://keybase.io/test/pgp_keys.asc
  pgp_key = "keybase:test"

  password_reset_required = false

  # SSH public key
  upload_iam_user_ssh_key = true

  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0sUjdTEcOWYgQ7ESnHsSkvPUO2tEvZxxQHUZYh9j6BPZgfn13iYhfAP2cfZznzrV+2VMamMtfiAiWR39LKo/bMN932HOp2Qx2la14IbiZ91666FD+yZ4+vhR2IVhZMe4D+g8FmhCfw1+zZhgl8vQBgsRZIcYqpYux59FcPv0lP1EhYahoRsUt1SEU2Gj+jvgyZpe15lnWk2VzfIpIsZ++AeUqyHoJHV0RVOK4MLRssqGHye6XkA3A+dMm2Mjgi8hxoL5uuwtkIsAll0kSfL5O2G26nsxm/Fpcl+SKSO4gs01d9V83xiOwviyOxmoXzwKy4qaUGtgq1hWncDNIVG/aQ=="
}

data "aws_iam_access_keys" "iam_user_devops_john" {
  user = module.iam_user_devops_john.iam_user_name
}

###################################################################
# IAM user without pgp_key (IAM access secret will be unencrypted)
###################################################################
module "iam_user_security_jane" {
  source = "../../../modules/iam-user"

  name = "security_jane"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
}

data "aws_iam_access_keys" "iam_user_security_jane" {
  user = module.iam_user_security_jane.iam_user_name
}

###################################################################
# IAM user with inactive IAM access key
###################################################################
module "iam_user_network_tom" {
  source = "../../../modules/iam-user"

  name = "network_tom"

  create_iam_user_login_profile = false
  create_iam_access_key         = true
  iam_access_key_status         = "Inactive"

}

data "aws_iam_access_keys" "iam_user_network_tom" {
  user = module.iam_user_network_tom.iam_user_name
}

# ###################################################################
# # IAM user with IAM policy attached
# ###################################################################

data "aws_iam_policy_document" "assume_roles_from_444469924026" {
  statement {
    sid       = "AssumeRolesFrom444469924026"
    actions = [
      "sts:AssumeRole"
    ]
    resources = [
      "arn:aws:iam::444469924026:role/*",
    ]
    effect = "Allow"
  }
}

#########################################
# IAM policy
#########################################

module "iam_policy_from_data_source_assume_roles_from_444469924026" {
  source = "../../../modules/iam-policy"

  name        = "assume_roles_from_444469924026"
  path        = "/"
  description = "assume_roles_from_444469924026"

  policy = data.aws_iam_policy_document.assume_roles_from_444469924026.json

  tags = {
    PolicyDescription = "Policy created using example from data source"
  }
}
