resource "yandex_kubernetes_cluster" "regional_cluster_filipp0vap" {
  name        = "filipp0vap-cluster"
  description = "cluster for netology diploma"

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
resource "yandex_kubernetes_node_group" "prod-node-group" {
  cluster_id  = yandex_kubernetes_cluster.regional_cluster_filipp0vap.id
  name        = "prod_nodes"
  description = "prod nodes"

  # labels = {
  #   "key" = "value"
  # }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.prod.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = ["${yandex_vpc_subnet.prod.zone}"]
    }
  }

  # maintenance_policy {
  #   auto_upgrade = true
  #   auto_repair  = true

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
}

resource "yandex_kubernetes_node_group" "preprod-node-group" {
  cluster_id  = yandex_kubernetes_cluster.regional_cluster_filipp0vap.id
  name        = "preprod_nodes"
  description = "preprod nodes"

  # labels = {
  #   "key" = "value"
  # }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.preprod.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = ["${yandex_vpc_subnet.preprod.zone}"]
    }
  }

  # maintenance_policy {
  #   auto_upgrade = true
  #   auto_repair  = true

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
}
resource "yandex_kubernetes_node_group" "dev-node-group" {
  cluster_id  = yandex_kubernetes_cluster.regional_cluster_filipp0vap.id
  name        = "dev_nodes"
  description = "dev nodes"

  # labels = {
  #   "key" = "value"
  # }

  instance_template {
    platform_id = "standard-v2"

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.dev.id}"]
    }

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
    }

    scheduling_policy {
      preemptible = true
    }

    container_runtime {
      type = "containerd"
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = ["${yandex_vpc_subnet.dev.zone}"]
    }
  }

  # maintenance_policy {
  #   auto_upgrade = true
  #   auto_repair  = true

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
}
