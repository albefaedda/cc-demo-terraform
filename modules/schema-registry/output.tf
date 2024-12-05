output "sr_cluster" {
  value = data.confluent_schema_registry_cluster.sr_cluster
}

output "env_manager_credentials" {
  sensitive = true
  value     = confluent_api_key.env-manager-schema-registry-api-key
}