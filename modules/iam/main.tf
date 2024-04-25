resource "aws_s3_bucket_policy" "cdn-oac-s3-policy" {
  bucket = var.bucket_id
  policy = data.aws_iam_policy_document.s3_bucket_policy.json
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid     = "AllowCloudFrontServicePrincipalReadOnly"
    effect  = "Allow"
    actions = [ "s3:GetObject" ]
    resources = [ "${var.bucket_arn}/*" ]
    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [var.cloudfront_arn]
    }
  }
}