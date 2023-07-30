dependency "vault" {
    config_path = "../vault"
    mock_outputs_allowed_terraform_commands = ["apply", "plan", "destroy", "output"]
    mock_outputs = {
        secrets = "secrets"
    }
}

include "root" {
  path = find_in_parent_folders()
  merge_strategy = "deep"
}

inputs = {
    admin_password = dependency.vault.outputs.secrets["mysql_root"]["key"]

    databases = {
        mailu: {},
        roundcube: {}
    }

    secrets = dependency.vault.outputs.secrets

    users = {
        mailu: {
            privileges: [
                { "database": "mailu", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ]},
                { "database": "roundcube", "grant": [ "ALTER", "CREATE", "DELETE", "DROP", "INDEX", "INSERT", "SELECT", "UPDATE" ]}
            ]
        }
    }

}

terraform {
  source = "git@github.com:StopDenBus/infrastructure_terraform.git//mysql?ref=main"
}
