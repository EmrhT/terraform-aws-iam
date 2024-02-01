# Playground AWS IAM Project with Terraform
1. A pet project for people recently join cloud engineering team.
2. Management folder represents management account in which there are IAM groups and users with different job roles such as
devops, network and security.
3. IAM policies are attached to IAM groups in management account to enable them assume roles in dev account.
4. Dev account folder has following resources;
  * IAM resource policies that enable IAM principals (roles and services) to consume AWS resources. They are either AWS-managed, job role or custom.
  * IAM roles to grant access to users in the management account.

# Usage
1. First, execute terraform init --> plan --> apply under management/iam folder as a user with required permissions to create IAM users and groups under management account.
2. Second, execute terraform init --> plan --> apply under dev/iam folder as a user with required permissions to create IAM policies and assumable roles under dev account.