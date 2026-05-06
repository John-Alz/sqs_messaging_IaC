variable "capacity" {
  description = "Nombre del proyecto"
  type        = string
}

variable "env" {
  description = "Ambiente (dev, qa, sbx, stg, pdn)"
  type        = string
}

variable "country" {
  description = "País de despliegue (co, pa, gt, ts)"
  type        = string
}

variable "confidentiality" {
  description = "Clasificación de confidencialidad"
  type        = string
}

variable "integrity" {
  description = "Clasificación de integridad"
  type        = string
}

variable "availability" {
  description = "Clasificación de disponibilidad"
  type        = string
}

variable "pci" {
  description = "Cumple con pci"
  type        = bool
}

variable "functionality" {
  description = "Funcionalidad"
  type        = string
}

variable "delay_seconds" {
  description = "Retraso en segundos"
  type        = number
}

variable "max_message_size" {
  description = "Tamaño máximo del mensaje"
  type        = number
}

variable "message_retention_seconds" {
  description = "Número de segundos de retención del mensaje"
  type        = number
}

variable "receive_wait_time_seconds" {
  description = "Número de segundos de espera de recepción del mensaje"
  type        = number
}



