# Terraform Configuration for IBM Cloud

This README file explains the Terraform configuration provided for managing resources on IBM Cloud. 

## Configuration Details

### Provider Configuration

The Terraform configuration uses the IBM Cloud provider to interact with IBM Cloud services. The provider configuration specifies the profile and region to use for the IBM Cloud resources:

```hcl
provider "ibm" {
  profile = "onyze"
  region  = "sa-east-1"
}
```

### Local Variables

Local variables are defined to facilitate reuse and maintainability of values throughout the configuration:

```hcl
locals {
    env          = "prd"
    name         = "onyze-k8s"
    key_name     = "prd-onyze-k8s"
    machine_type = "b3c.4x16"
    region       = "sa-east-1"
    worker_count = 3
    versioning   = true
}
```

### Resources

#### IBM Container Cluster

This configuration defines an IBM Container Cluster resource named "kubernetes_cluster". It specifies the name, region, machine type, and worker count for the Kubernetes cluster:

```hcl
resource "ibm_container_cluster" "kubernetes_cluster" {
  name         = local.name
  region       = local.region
  machine_type = local.machine_type
  worker_count = local.worker_count
}
```

#### IBM Cloud Object Storage (COS) Bucket Object

This configuration defines an IBM COS Bucket Object resource named "cos". It specifies the bucket name, access control list (ACL), and versioning configuration:

```hcl
resource "ibm_cos_bucket_object" "cos" {
    bucket = local.name
    acl    = "private"

    versioning {
        enabled = local.versioning
    }
}
```

### Terraform Backend Configuration

The Terraform configuration also includes a backend configuration for storing the state file in IBM Cloud Object Storage (COS). This ensures centralized state management and collaboration:

```hcl
terraform {
  backend "cos" {
    bucket  = "onyze-infra"
    key     = "terraform/prd/state-lock-file"
    region  = "sa-east-1"
    profile = "onyze"
  }
}
```

## Usage

To use this Terraform configuration, follow these steps:

1. Ensure you have the IBM Cloud CLI installed and configured with the appropriate credentials.
2. Install Terraform on your local machine.
3. Copy the configuration provided in this README into your Terraform configuration files.
4. Run `terraform init` to initialize your Terraform configuration.
5. Run `terraform plan` to preview the changes that Terraform will make.
6. Run `terraform apply` to apply the changes and create the resources on IBM Cloud.