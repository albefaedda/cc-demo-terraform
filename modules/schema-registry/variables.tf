variable "environment" {
  type = string
}

# variable "schema_registry_cluster" {
#   type = object({
#     cloud = string
#     region  = string
#     package = string
#   })
#   validation {
#     condition = (
#       contains(["ESSENTIALS", "ADVANCED"], var.schema_registry_cluster.package)
#     )
#     error_message = <<EOT
# - cluster.availability => ESSENTIALS or ADVANCED 
#     EOT
#   }
# }