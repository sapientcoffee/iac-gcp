variable "region" {
  description = "The region that the resource will be deployed to"
  type    = string
  default = "us-central1"

  validation {
    condition = contains(["europe-west1", "europe-west2", "us-central1"], var.region)
    error_message = "Can only deploy to UK (europe-west2), Belgium (europe-west1) or Iowa (us-central1) due to compliance and low CO2"
    
  }
}

variable "instance_type" {
  type    = string
  default = "n1-standard-1"
}

variable "project" {
  type = string
  default = "coffee-with-iac"
}

variable "prefix" {
  type = string
  default = "rob"
}

variable "env" {
  type = string
  default = "coffee"
}