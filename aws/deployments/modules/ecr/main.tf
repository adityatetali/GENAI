locals {
  create_private_repository = var.create && var.create_repository && var.repository_type == "Private"
  create_public_repository = var.create && var.create_repository && var.repository_type == "Public" 
}

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

# Policy used by both public and Private repositories
data "aws_iam_policy_document" "repository" {
  count = var.create && var.create_repository && var.create_repository_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.repository_type == "public" ? [1] : []

    content {
      sid = "PublicReadOnly"
     
      principals {
        type = "AWS"
        identifiers = coalescelist(
            var.repository_read_access_arns,
            ["*"],
        )
      }

      actions = [
        "ecr-public:BatchGetImage",
        "ecr-public:GetDownloadUrlForLayer",
      ]
    }
  }

  dynamic "statement" {
    for_each = var.repository_type == "private" ? [1] : []

    content {
      sid = "PrivateReadOnly"

      principals {
        type = "AWS"
        identifiers = coalescelist(
            concat(var.repository_read_access_arns, var.repository_read_write_access_arns),
            [arn]
        )
      }
    }
    
  }
}