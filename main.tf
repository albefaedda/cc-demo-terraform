
resource "confluent_environment" "environment" {
  display_name = var.environment.name

  stream_governance {
    package = var.environment.governance_package
  }
}

module "cluster" {
  for_each    = { for cluster in var.clusters : cluster.display_name => cluster }
  source      = "./modules/cluster"
  environment = resource.confluent_environment.environment.id
  cluster     = each.value
}

# module "schema-registry" {
#   source      = "./modules/schema-registry"
#   environment = resource.confluent_environment.environment.id
# }