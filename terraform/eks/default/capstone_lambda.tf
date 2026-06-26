data "archive_file" "lambda_zip" {
  type = "zip"

  source_file = "${path.module}/lambda/lambda_function.py"

  output_path = "${path.module}/lambda/lambda.zip"
}

resource "aws_iam_role" "lambda" {
  name = "bedrock-asset-processor-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [{
      Effect = "Allow"

      Principal = {
        Service = "lambda.amazonaws.com"
      }

      Action = "sts:AssumeRole"
    }]
  })

  tags = module.tags.result
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "asset_processor" {

  function_name = "bedrock-asset-processor"

  role = aws_iam_role.lambda.arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  tags = merge(
    module.tags.result,
    {
      Project = "karatu-2025-capstone"
    }
  )
}

resource "aws_lambda_permission" "allow_bucket" {

  statement_id = "AllowExecutionFromS3"

  action = "lambda:InvokeFunction"

  function_name = aws_lambda_function.asset_processor.function_name

  principal = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.assets.arn
}
