data "aws_kms_key" "kms_sqs" {
  provider = aws.main
  key_id = "alias/aws/sqs"
}