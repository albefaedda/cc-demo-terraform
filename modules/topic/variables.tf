variable "environment" {
  type = string
}

variable "cluster" {
  type = string
}

variable "rbac_enabled" {
  type = bool
}

variable "topic" {
  type = object({
    name       = string
    partitions = optional(number)
    config     = optional(map(string))
    consumer   = optional(string)
    producer   = optional(string)
  })
}

variable "admin_sa" {
  type = object({
    id     = string
    secret = string
  })
}

