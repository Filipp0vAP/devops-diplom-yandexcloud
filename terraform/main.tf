resource "yandex_kubernetes_cluster" "regional_cluster_resource_name" {
  name        = "name"
  description = "description"

  network_id = yandex_vpc_network.network-1.id

  master {
    regional {
      region = "ru-central1"

      location {
        zone      = yandex_vpc_subnet.prod.zone
        subnet_id = yandex_vpc_subnet.prod.id
      }

      location {
        zone      = yandex_vpc_subnet.preprod.zone
        subnet_id = yandex_vpc_subnet.preprod.id
      }

      location {
        zone      = yandex_vpc_subnet.dev.zone
        subnet_id = yandex_vpc_subnet.dev.id
      }
    }

    # version   = "1.14"
    public_ip = true

    # maintenance_policy {
    #   auto_upgrade = true

    #   maintenance_window {
    #     day        = "monday"
    #     start_time = "15:00"
    #     duration   = "3h"
    #   }

    #   maintenance_window {
    #     day        = "friday"
    #     start_time = "10:00"
    #     duration   = "4h30m"
    #   }
    # }

    master_logging {
      enabled                    = true
      folder_id                  = var.yandex_folder_id
      kube_apiserver_enabled     = true
      cluster_autoscaler_enabled = true
      events_enabled             = true
      audit_enabled              = true
    }
  }

  service_account_id      = yandex_iam_service_account.k8s-sa.id
  node_service_account_id = yandex_iam_service_account.k8s-node-sa.id

  # labels = {
  #   my_key       = "my_value"
  #   my_other_key = "my_other_value"
  # }

  release_channel = "STABLE"
}
