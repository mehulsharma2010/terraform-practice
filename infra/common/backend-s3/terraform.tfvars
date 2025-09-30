#################### Region ####################
region = "ap-south-1"

################### Bucket Behavior ###################
bucket = "ot-terraform-state-bucket"
bucket_names   = ["ot-terraform-state-bucket"]
force_destroy = true

################### Versioning ###################
versioning = {
  enabled = "false"
}

################### Public Access Block ###################
block_public_acls       = true
block_public_policy     = true
restrict_public_buckets = true

################### Cost Optimization ###################
intelligent_tiering = {}

################### ACL & Ownership ###################
control_object_ownership = true
object_ownership         = "BucketOwnerEnforced"

################### Other Optional Config ###################
request_payer       = "BucketOwner"
lifecycle_rule = [
  {
    id                                     = "expire-old-versions"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 7

    noncurrent_version_expiration = {
      days = 30
    }

    expiration = {
      days = 365
    }

    filter = {
      prefix = ""
    }

    tags = {
      rule = "expire"
    }
  }
]

  cors_rule = [
    {
      allowed_methods = ["PUT", "POST"]
      allowed_origins = ["https://modules.tf", "https://terraform-aws-modules.modules.tf"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
      }, {
      allowed_methods = ["PUT"]
      allowed_origins = ["https://example.com"]
      allowed_headers = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  ]


  metric_configuration = [
    {
      name = "documents"
      filter = {
        prefix = "documents/"
        tags = {
          priority = "high"
        }
      }
    },
    {
      name = "other"
      filter = {
        tags = {
          production = "true"
        }
      }
    },
    {
      name = "all"
    }
  ]
