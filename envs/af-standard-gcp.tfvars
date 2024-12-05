environment =  {
  name = "test-ecommerce"
  governance_package = "ESSENTIALS"
}

clusters = [
  {
    display_name = "demo-ecommerce"
    availability = "MULTI_ZONE"     # SINGLE_ZONE / MULTI_ZONE
    cloud        = "GCP"            # GCP / AWS / AZURE
    region       = "europe-west2"
    type         = "STANDARD"       # BASIC / STANDARD / DEDICATED

    serv_account_admin = {
      name = "afaedda-sa"
      role = "CloudClusterAdmin"
    }
    serv_accounts = [
      {
        name = "orders-enrichment-sa"
        groups = [
          {
            group = "orders-enrichment-app",
            role  = "DeveloperRead"
          }
        ]
      },
      {
        name = "connector-sa"
      }
    ]
    topics = [
      {
        name       = "ecommerce.orders.avro",
        partitions = 4,
        config     = {
            "cleanup.policy" = "delete",
            "retention.ms" = "2629746000"
        },
        producer = "connector-sa"
        consumer = "orders-enrichment-sa"
      }, 
      {
        name       = "ecommerce.products.avro",
        partitions = 2,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "connector-sa"
        consumer = "orders-enrichment-sa"
      }, 
      {
        name       = "ecommerce.customers.avro",
        partitions = 2,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "connector-sa"
        consumer = "orders-enrichment-sa"
      },
      {
        name       = "ecommerce.orders-enriched.avro",
        partitions = 4,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "orders-enrichment-sa"
        consumer = "connector-sa"
      }
    ] 
  }
]

gcp_project = {  
  name          = "solutionsarchitect-01"
  region        = "europe-west2"
  auth_file = "../tf-gke-keyfile.json"
}