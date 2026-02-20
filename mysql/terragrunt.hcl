dependency "vault" {
    config_path = "../vault"
    mock_outputs_allowed_terraform_commands = ["apply", "plan", "destroy", "output"]
    mock_outputs = {
        secrets = "secrets"
    }
}

include "root" {
  path = find_in_parent_folders("root.hcl")
  merge_strategy = "deep"
}

inputs = {
    endpoint = "stoppi.gusek.info:32307"

    admin_password = dependency.vault.outputs.secrets["mysql_root"]["key"]

    databases = {
        budget: {},
        dungeon: {},
        mailu: {},
        roundcube: {},
        wishlist: {}
    }

    secrets = dependency.vault.outputs.secrets

    users = {
        budget: {
            privileges: [
                { "database": "budget", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ] }
            ]
        },
        dungeon: {
            privileges: [
                { "database": "dungeon", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ] }
            ]
        },
        mailu: {
            privileges: [
                { "database": "mailu", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ] },
                { "database": "roundcube", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ] }
            ]
        },
        wishlist: {
            privileges: [
                { "database": "wishlist", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ] }
            ]
        },
    }
}

terraform {
  source = "git@github.com:StopDenBus/infrastructure_terraform.git//mysql?ref=main"
}
