resource "aws_iam_user" "developer" {
  name = "bedrock-dev-view"

  tags = merge(
    module.tags.result,
    {
      Project = "karatu-2025-capstone"
    }
  )
}

resource "aws_iam_user_policy_attachment" "readonly" {

  user = aws_iam_user.developer.name

  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_policy" "assets_upload" {

  name = "bedrock-assets-upload"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "s3:PutObject"

        ]

        Resource = "${aws_s3_bucket.assets.arn}/*"

      }

    ]

  })
}

resource "aws_iam_user_policy_attachment" "assets_upload" {

  user = aws_iam_user.developer.name

  policy_arn = aws_iam_policy.assets_upload.arn
}
