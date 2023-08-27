inputs = {
    host = "samba.gusek.info"

    authorized_keys = {
        root = {
            keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBkmaLCMI0m/jaGZ1IrkitzUg6cb4+2aepfyp20x7RLJ root@stoppi",
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE+m0RtKRNVwkLu+EP8i6yd2ID2qAi2oO2CokOggyYJJ michael@janicelnx"
            ]
        }
    }

    ntp_additional_configuration = [
        "allow 192.168.0.0/24",
        "bindcmdaddress 192.168.0.2",
        "ntpsigndsocket /var/lib/samba/ntp_signd",
    ]

    ntp_pools = [
        "de.pool.ntp.org"
    ]
}
