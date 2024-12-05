output "environment" {
  value = resource.confluent_environment.environment.id
}

output "cluster" {
  value = {
    for k, cluster in module.cluster : k => {
      id                 = cluster.ccloud_cluster.id
      display_name       = cluster.ccloud_cluster.display_name
      kind               = cluster.ccloud_cluster.kind
      rbac_crn           = cluster.ccloud_cluster.rbac_crn
      region             = cluster.ccloud_cluster.region
      cloud              = cluster.ccloud_cluster.cloud
      availability       = cluster.ccloud_cluster.availability
      bootstrap_endpoint = cluster.ccloud_cluster.bootstrap_endpoint
      topics             = cluster.topics
      acls               = cluster.acls
      rbac_enabled       = cluster.rbac_enabled
      connector          = cluster.source_connector
    }
  }
}

output "service_account_admin" {
  sensitive = true
  value = {
    for k, cluster in module.cluster : k => {
      admin_sa = cluster.service_account_admin
    }
  }
}

output "service_accounts" {
  sensitive = true
  value = {
    for k, cluster in module.cluster : k => {
      admin_sa = cluster.service_accounts
    }
  }
}

output "sr_cluster" {
  value = module.schema-registry.sr_cluster
}

output "env_manager_service_account" {
  sensitive = true
  value     = module.schema-registry.env_manager_credentials
}