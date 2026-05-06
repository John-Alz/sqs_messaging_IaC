module "sqs" {
  providers = {
    aws.main = aws.main
  }

  source                     = "git@github.com:NequiTI/terraform_sqs_Mod.git//modules/sqs?ref=v2.0.0"
  capacity                   = var.capacity
  country                    = var.country
  env                        = var.env
  confidentiality            = var.confidentiality
  integrity                  = var.integrity
  availability               = var.availability
  pci                        = var.pci
  functionality              = var.functionality

  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  kms_master_key_id          = local.kms_master_key_id
  redrive_policy             = local.redrive_policy
}

module "sqs_dlq" {
  providers = {
    aws.main = aws.main
  }

  source                     = "git@github.com:NequiTI/terraform_sqs_Mod.git//modules/sqs?ref=v2.0.0"
  capacity                   = var.capacity
  country                    = var.country
  env                        = var.env
  confidentiality            = var.confidentiality
  integrity                  = var.integrity
  availability               = var.availability
  pci                        = var.pci
  functionality              = "${var.functionality}-dlq"

  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  message_retention_seconds  = var.message_retention_seconds
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  kms_master_key_id          = local.kms_master_key_id
  arn_sqs_source_to_this_dlq = [module.sqs.sqs_queue_arn]
}
