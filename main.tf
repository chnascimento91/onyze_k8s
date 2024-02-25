locals {
    env = "prd"
    name = "onyze-k8s"
    key_name = "prd-onyze-k8s"
    machine_type = "b3c.4x16"
    region = "sa-east-1"
    worker_count = 3
    versioning = true
}

resource "ibm_container_cluster" "kubernetes_cluster" {
  name = local.name
  region = local.region
  machine_type = local.machine_type
  worker_count = local.worker_count
}

resource "ibm_cos_bucket_object" "cos" {
    bucket = local.name
    acl = "private"

    versioning {
        enabled = local.versioning
    }
}