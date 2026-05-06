# SQS Messaging IaC

Proyecto Terraform que despliega una cola SQS principal con su Dead Letter Queue (DLQ) en AWS, usando el módulo interno de Nequi `terraform_sqs_Mod`.

## Arquitectura

```
Productor → SQS Principal → (3 intentos fallidos) → DLQ
```

- **SQS Principal** (`sqs-reto-co-sqs-challenge-sbx`): recibe los mensajes. Si un mensaje es recibido 3 veces sin ser eliminado, se redirige automáticamente a la DLQ.
- **DLQ** (`sqs-reto-co-sqs-challenge-dlq-sbx`): almacena los mensajes que no pudieron ser procesados.

## Configuración del redrive

| Parámetro | Valor         |
|---|---------------|
| `maxReceiveCount` | 2 |
| `delay_seconds` | 90            |
| `max_message_size` | 2048 bytes    |
| `message_retention_seconds` | 86400 (1 día) |
| `receive_wait_time_seconds` | 10            |

## Despliegue

```bash
# Inicializar el proyecto
terraform init

# Ver el plan de ejecución
terraform plan

# Aplicar los cambios
terraform apply
```

## Pruebas

### 1. Enviar un mensaje a la SQS principal
```bash
aws sqs send-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/<account_id>/sqs-reto-co-sqs-challenge-sbx \
  --message-body "mensaje de prueba"
```

### 2. Recibir el mensaje (simular fallo — repetir 3 veces sin eliminar)
```bash
aws sqs receive-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/<account_id>/sqs-reto-co-sqs-challenge-sbx
```

### 3. Verificar mensajes en la SQS principal
```bash
aws sqs get-queue-attributes \
  --queue-url https://sqs.us-east-1.amazonaws.com/<account_id>/sqs-reto-co-sqs-challenge-sbx \
  --attribute-names ApproximateNumberOfMessages
```

### 4. Verificar que el mensaje llegó a la DLQ (después del 3er intento)
```bash
aws sqs get-queue-attributes \
  --queue-url https://sqs.us-east-1.amazonaws.com/<account_id>/sqs-reto-co-sqs-challenge-dlq-sbx \
  --attribute-names ApproximateNumberOfMessages
```

### 5. Leer el mensaje desde la DLQ
```bash
aws sqs receive-message \
  --queue-url https://sqs.us-east-1.amazonaws.com/<account_id>/sqs-reto-co-sqs-challenge-dlq-sbx
```

## Destruir la infraestructura

```bash
terraform destroy
```
