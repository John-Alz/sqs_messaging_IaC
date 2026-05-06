locals {

  kms_master_key_id = data.aws_kms_key.kms_sqs.id

  redrive_policy = {
    deadLetterTargetArn = module.sqs_dlq.sqs_queue_arn
    maxReceiveCount      = 2
  }

}