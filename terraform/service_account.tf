## Create SA
resource "yandex_iam_service_account" "k8s-sa" {
  folder_id = var.yandex_folder_id
  name      = "k8s-sa"
}

## Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-clister-agent" {
  folder_id = var.yandex_folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
}
resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-editor" {
  folder_id = var.yandex_folder_id
  role      = "k8s.editor"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
}
resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-serviceAccounts-user" {
  folder_id = var.yandex_folder_id
  role      = "iam.serviceAccounts.user"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-sa.id}"
}
## Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-k8s-static-key" {
  service_account_id = yandex_iam_service_account.k8s-sa.id
  description        = "static access key for object storage"
}


resource "yandex_iam_service_account" "k8s-node-sa" {
  folder_id = var.yandex_folder_id
  name      = "k8s-node-sa"
}

## Grant permissions
resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-node-push" {
  folder_id = var.yandex_folder_id
  role      = "container-registry.images.pusher"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-node-sa.id}"
}
resource "yandex_resourcemanager_folder_iam_member" "sa-k8s-node-pull" {
  folder_id = var.yandex_folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s-node-sa.id}"
}
## Create Static Access Keys
resource "yandex_iam_service_account_static_access_key" "sa-k8s-node-static-key" {
  service_account_id = yandex_iam_service_account.k8s-node-sa.id
  description        = "static access key for object storage"
}