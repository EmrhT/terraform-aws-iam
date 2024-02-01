data "aws_iam_policy_document" "bucket_policy_list_get_location" {
  statement {
    sid       = "AllowS3ListGetLocation"
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
    effect = "Allow"
  }
}

#########################################
# IAM policy
#########################################

module "iam_policy_from_data_source" {
  source = "../../../modules/iam-policy"

  name        = "bucket_policy_list_get_location"
  path        = "/"
  description = "example policy for bucket_policy_list_get_location"

  policy = data.aws_iam_policy_document.bucket_policy_list_get_location.json

  tags = {
    PolicyDescription = "Policy created using example from data source"
  }
}

