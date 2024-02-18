## Create SA
resource "yandex_iam_service_account" "terraform-sa" {
  folder_id = var.yandex_folder_id
  name      = "terraform-sa"
}

## Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.yandex_folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.terraform-sa.id}"
}

## Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.terraform-sa.id
  description        = "static access key for object storage"
}
