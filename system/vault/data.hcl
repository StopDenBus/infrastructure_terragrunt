inputs = {
    host = "vault.gusek.info"

    execute_module_nginx = true
    execute_module_vault = true

    authorized_keys = {
        root = {
            keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkmaLCMI0m/jaGZ1IrkitzUg6cb4+2aepfyp20x7RLJ root@stoppi",
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+m0RtKRNVwkLu+EP8i6yd2ID2qAi2oO2CokOggyYJJ michael@janicelnx"
            ]
        }
    }

    basic_packages_apt = [
        "curl",
        "gpg",
        "software-properties-common",
        "tmux",
        "vim",
        "wget"
    ]

    log_rotate = {
        vault = {
            config = <<EOT
/var/log/vault/vault_audit.log {
rotate 10
daily
#Do not execute rotate if the log file is empty.
notifempty
missingok
compress
#Set compress on next rotate cycle to prevent entry loss when performing compression.
delaycompress
copytruncate
extension log
dateext
dateformat %Y-%m-%d.
}
            EOT
        }
    }   

    packages_apt = [
        "jq",
	"unzip"
    ]

    nginx_virtual_hosts = {
        "vault.gusek.info" = {
            upstream = "https://127.0.0.1:8200"
        }
    }

    repositories_apt = {
        vault = {
            component = "main",
            distribution = "jammy",
            gpg_url = "https://apt.releases.hashicorp.com/gpg",
            name = "vault",
            url = "https://apt.releases.hashicorp.com",            
        }
    }
}
