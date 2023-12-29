include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

inputs = {
    address  = "https://vault.gusek.info"
    mounts = {
        secrets: {
            type: "kv-v2"
            description: "secrets store"
        },
        ssh: {
            type: "ssh"
            description: "ssh mount"
        }

    }
    policies = {
        admin: {
            policy: {
                path: {
                    "auth/*": {
                        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
                    },
                    "sys/auth": {
                        capabilities = ["read"]
                    },
                    "sys/policies/acl/*": {
                        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
                    },
                    "sys/policies/acl": {
                        capabilities = ["list"]
                    },
                    "secrets/*": {
                        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
                    },
                    "sys/mounts/*": {
                        capabilities = ["create", "read", "update", "delete", "list", "sudo"]
                    },
                    "sys/health": {
                        capabilities = ["read", "sudo"]    
                    },
                    "sys/capabilities": {
                        capabilities = ["create", "update"]
                    },
                    "sys/capabilities-self": {
                        capabilities = ["create", "update"]
                    },
                    "identity/*": {
                        capabilities = [ "create", "read", "update", "delete", "list" ]
                    }
                }
            }
        }
        ssh: {
            policy: {
                path: {
                    "ssh/sign/*": {
                        capabilities = ["create", "read", "update", "delete", "list"]
                    }
                }
            }
        }
        terraform: { 
            policy: {
                path: {
                    "sys/policies/acl/*": {
                        capabilities = [ "create", "read", "update", "patch", "delete", "list" ]
                    },
                    "auth/token/create": {
                        capabilities = [ "update" ]
                    },
                    "sys/mounts": {
                        capabilities = [ "create", "read", "update", "patch", "delete", "list" ]
                    }
                    "sys/mounts/*": {
                        capabilities = [ "create", "read", "update", "patch", "delete", "list" ]
                    }                    
                    "secrets/*": {
                        capabilities = [ "create", "read", "update", "patch", "delete", "list" ]
                    }
                }
            }
        },
        external-secrets: {
            policy: {
                path: {
                    "secrets/*": {
                        capabilities = [ "read", "list" ]
                    },
                    "auth/kubernetes/login": {
                        capabilities = [ "update" ]
                    }      
                }
            }
        }
    }
    secrets = {
        argocd_dex_client: {
            name: "kubernetes/dex/clients/argocd"
        },
        grafana_admin: {
            name: "kubernetes/grafana/admin"
        },
        grafana_dex_client: {
            name: "kubernetes/dex/clients/grafana"
        },
        ldap_dex: {
            name: "ldap/dex"
        },
        mailu_admin: {
            name: "kubernetes/mailu/admin"
        },        
        mailu_secret_key: {
            name: "kubernetes/mailu/secret_key"
        },
        mysql_budget: {
            name: "mysql/budget"
        },
        mysql_mailu: {
            name: "mysql/mailu"
        },                     
        mysql_root: {
            name: "mysql/admin"
        },
        vault_dex_client: {
            name: "kubernetes/dex/clients/vault"
        }
    }
    
    token    = local.token
}

locals {
    token = get_env("VAULT_TOKEN")
}

terraform {
  source = "git@github.com:StopDenBus/infrastructure_terraform.git//vault?ref=main"
}