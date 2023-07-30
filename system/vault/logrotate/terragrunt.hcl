include "data" {
    path = find_in_parent_folders("data.hcl")
    merge_strategy = "deep"
}

include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

terraform {
    source = "git@github.com:StopDenBus/infrastructure_terraform.git//system/vault/logrotate?ref=main"
}