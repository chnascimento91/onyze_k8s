terraform {
  backend "cos" {
    bucket = "onyze-infra"
    key = "terraform/prd/state-lock-file"
    region = "sa-east-1"
    profile = "onyze"
  }
}