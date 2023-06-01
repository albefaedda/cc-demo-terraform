environment = "env-zg931d"

clusters = [
  {
    display_name = "basic-ecommerce"
    availability = "SINGLE_ZONE"
    cloud        = "GCP"
    region       = "europe-west2"
    type         = "BASIC" # BASIC / STANDARD / DEDICATED

    serv_account_admin = {
      name = "afaedda-sa-man"
      role = "CloudClusterAdmin"
    }
  
    topics = [
      {
        name       = "json.streaming.orders"
        partitions = 3,
      },
      {
        name = "json.tracking.inventory"
        partitions = 2
      }, 
      {
        name = "json.data.products"
        partitions = 5
        config     = {
            "cleanup.policy" = "compact"
        },

      }, 
      {
        name = "json.data.customers"
        partitions = 5
        config     = {
            "cleanup.policy" = "compact"
        },

      }
    ] 
  }
]
