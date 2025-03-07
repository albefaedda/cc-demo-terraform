environment =  {
  name = "test-csfle-gcp"
  governance_package = "ADVANCED"   # ESSENTIALS / ADVANCED
}

clusters = [
  {
    display_name = "demo-ecommerce"
    availability = "SINGLE_ZONE"     # SINGLE_ZONE / MULTI_ZONE
    cloud        = "GCP"            # GCP / AWS / AZURE
    region       = "europe-west2"
    type         = "STANDARD"       # BASIC / STANDARD / DEDICATED

    serv_account_admin = {
      name = "afaedda-sa"
      role = "CloudClusterAdmin"
    }
    serv_accounts = [
      {
        name = "customers-sa"
        groups = [
          {
            group = "customers-management-app",
            role  = "DeveloperRead"
          }
        ]
      }
    ]
    topics = [
      {
        name       = "customers",
        partitions = 2,
        config     = {
            "cleanup.policy" = "delete"
        },
        producer = "customers-sa"
        consumer = "customers-sa"
      }
    ] 
  }
]

