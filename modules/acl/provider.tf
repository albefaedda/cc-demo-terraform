# Configure the Confluent Cloud Provider
terraform {
  required_version = ">= 0.15.0"
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.11.0"
    }
  }
}
 