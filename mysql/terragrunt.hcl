terraform {
  source = "git@github.com:StopDenBus/infrastructure_terraform.git//mysql?ref=main"
}

dependency "vault" {
    config_path = "../vault"
    mock_outputs_allowed_terraform_commands = ["apply", "plan", "destroy", "output"]
    mock_outputs = {
        secrets = "secrets"
    }
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

remote_state {
    backend = "gcs"
    config = {
        bucket  = "mgusek-terraform"
        prefix  = "terraform/mysql/state"
        encryption_key = "SOtMtyaeyXNOj/1wqHzDK0nBWrpAQGtrJ4r/tg/mBY4="
        credentials = "/home/micha/google/key.json"
    }
}
