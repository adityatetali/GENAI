resource "aws_s3_bucket" "s3_bucket" {
    bucket = var.s3_bucket_name
  tags = var.tags
}

/*resource "aws_s3_bucket_object" "object_file" {
    for_each = fileset("uploads/", "*")
    bucket = aws_s3_bucket.s3_bucket.id
    key = each.value
    source = "uploads/${each.value}"
  
} */

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.s3_bucket
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}

/*resource "aws_s3_bucket_policy" "s3_bucket_policy" {
    bucket = aws_s3_bucket.s3_bucket.id

    policy = <<EOF
    {
        "Version": "2012-10-17"
        "Id": "Policy1415115909152"
        "Statement": [
            {
                "Sid": "Access-to-specific-VPCE-only"
                "Principal": "*"
                "Action": "s3:GetObject",
                "Effect": "Allow"
                "Resource": ["arn:aws:s3:::${var.s3_bucket_name}/*"]
                "Condition": {
                    "StringEquals": {
                        "aws:sourceVpce": "${var.vpc_name}"
                    }
                }
            }
        ]
    }
    EOF
    depends_on = [ aws_s3_bucket_public_access_block.app ]

} */

resource "aws_s3_bucket_policy" "my_bucket_policy" {
    bucket = aws_s3_bucket.s3_bucket.id
    policy = jsonencode({
        "Version": "2012-10-17"
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Service": "Kendra.amazonaws.com"
                },
                "Action": [
                    "s3:ListBucket",
                    "s3:GetObject",
                    "s3:GetObjectTagging",
                    "s3:GetObjectVersion"
                ],
                "Resource": [ "${aws_s3_bucket.s3_bucket.arn}", "${aws_s3_bucket.s3_bucket.arn}/*"]
                "Condition" : {
                "StringEquals" : {
                    "aws:sourceVpce": "${var.vpc_name}"
                    }
                }
            }
        ]
    })
}