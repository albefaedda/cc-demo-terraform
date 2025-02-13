environment =  {
  name = "test-ecommerce"
  governance_package = "ADVANCED"   # ESSENTIALS / ADVANCED
}

clusters = [
  {
    display_name = "demo-ecommerce"
    availability = "MULTI_ZONE"     # SINGLE_ZONE / MULTI_ZONE
    cloud        = "GCP"            # GCP / AWS / AZURE
    region       = "europe-west1"
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
        groups = [
          {
            group = "demo-schemahistory",
            role  = "DeveloperRead"
          }
        ]
      }
    ]
    topics = [
      {
        name       = "demo.ecommerce.orders-dlq",
        partitions = 1,
        config     = {
            "cleanup.policy" = "delete",
            "retention.ms" = "2629746000"
        },
        producer = "orders-enrichment-sa"
        consumer = "orders-enrichment-sa"
      },
      {
        name       = "demo.ecommerce.orders",
        partitions = 4,
        config     = {
            "cleanup.policy" = "delete",
            "retention.ms" = "2629746000"
        },
        producer = "orders-enrichment-sa"
        consumer = "orders-enrichment-sa"
      }, 
      {
        name       = "demo.ecommerce.products",
        partitions = 4,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "connector-sa"
        consumer = "orders-enrichment-sa"
      }, 
      {
        name       = "demo.ecommerce.customers",
        partitions = 2,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "connector-sa"
        consumer = "orders-enrichment-sa"
      },
      {
        name       = "demo.ecommerce.orders-enriched",
        partitions = 4,
        config     = {
            "cleanup.policy" = "delete"
        },
        producer = "orders-enrichment-sa"
        consumer = "orders-enrichment-sa"
      },
      {
        name       = "demo.ecommerce.orders-total",
        partitions = 4,
        config     = {
            "cleanup.policy" = "compact"
        },
        producer = "orders-enrichment-sa"
        consumer = "connector-sa"
      },
#      {
#        name       = "orders-enrichment-app-demo.ecommerce.orders-total-changelog",
#        partitions = 4,
#        config     = {
#            "cleanup.policy" = "compact"
#        },
#        producer = "orders-enrichment-sa"
#        consumer = "orders-enrichment-sa"
#      },
      {
        name       = "orders-enrichment-app-demo.ecommerce.orders-total-repartition",
        partitions = 4,
        config     = {
            "cleanup.policy" = "delete",
            "retention.ms" = "-1"
        },
        producer = "orders-enrichment-sa"
        consumer = "orders-enrichment-sa"
      },
      {
        name       = "dbhistory.demo.ecommerce.schemas",
        partitions = 1,
        config     = {
            "cleanup.policy" = "delete",
            "retention.ms" = "-1"
        },
        producer   = "connector-sa"
        consumer   = "connector-sa"
      }
    ] 

    acls = [
      {
        resource_type   = "CLUSTER"
        resource_name   = "kafka-cluster"
        service_account = "connector-sa"
        pattern_type    = "LITERAL"  
        operation       = "DESCRIBE"   
        permission      = "ALLOW"
      },
      {
        resource_type   = "GROUP"
        resource_name   = "demo-schemaregistry"
        service_account = "connector-sa"
        pattern_type    = "LITERAL"  
        operation       = "READ"   
        permission      = "ALLOW"
      },
      {
        resource_type   = "TOPIC"
        resource_name   = "orders-enrichment-app-"
        service_account = "orders-enrichment-sa"
        pattern_type    = "PREFIXED"  
        operation       = "ALL"   
        permission      = "ALLOW"
      }
    ]
  }
]

gcp_project = {  
  name          = "solutionsarchitect-01"
  region        = "europe-west2"
  auth_file = "../tf-gke-keyfile.json"
}