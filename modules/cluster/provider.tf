# Configure the Confluent Cloud Provider
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.43.0"
    }
  }
} 