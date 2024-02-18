## Use keys to create bucket
resource "yandex_kms_symmetric_key" "terraform-state-key" {
  name              = "terraform-state-bucket-key"
  folder_id         = var.yandex_folder_id
  description       = "key for terraform-state bucket"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}

resource "yandex_storage_bucket" "s3-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "filipp0vap-diploma-terraform-state"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.terraform-state-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  anonymous_access_flags {
    read = false
    list = false
  }
}
