resource "yandex_compute_instance" "preprod_master_node" {
  name                      = "preprod-master-node"
  hostname                  = "preprod-master-node"
  allow_stopping_for_update = true
  zone                      = yandex_vpc_subnet.preprod.zone
  scheduling_policy {
    preemptible = true
  }
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd827b91d99psvq5fjit"
      size     = 40
      type     = "network-ssd"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.preprod.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("./id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "preprod_worker_node" {
  count    = 2
  name     = "preprod-worker-node-${count.index}"
  hostname = "preprod-worker-node-${count.index}"

  allow_stopping_for_update = true

  zone = yandex_vpc_subnet.preprod.zone

  scheduling_policy {
    preemptible = true
  }
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd827b91d99psvq5fjit"
      size     = 30
      type     = "network-ssd"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.preprod.id
    nat       = true
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${file("./id_rsa.pub")}"
  }
}