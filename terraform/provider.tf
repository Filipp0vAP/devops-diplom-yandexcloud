# Base Terraform provider definition.
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }

  required_version = ">= 0.13"

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "filipp0vap-diploma-terraform-state"
    region   = "ru-central1"
    key      = "terraform-state-key"
    # access_key provided via AWS_ACCESS_KEY_ID
    # secret_key provided via AWS_SECRET_ACCESS_KEY

    skip_region_validation      = true
    skip_credentials_validation = true
    workspace_key_prefix        = "workspaces"
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

data "terraform_remote_state" "vpc" {
  backend   = "s3"
  workspace = terraform.workspace
  config = {
    endpoint = "storage.yandexcloud.net"
    bucket   = "filipp0vap-diploma-terraform-state"
    region   = "ru-central1"
    key      = "terraform-state-key"
    # access_key provided via AWS_ACCESS_KEY_ID
    # secret_key provided via AWS_SECRET_ACCESS_KEY

    skip_region_validation      = true
    skip_credentials_validation = true
    workspace_key_prefix        = "workspaces"
  }
}
