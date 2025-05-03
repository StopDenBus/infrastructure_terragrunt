locals {
    encryption_key = get_env("GOOGLE_ENCRYPTION_KEY")
}

remote_state {
    backend = "gcs"
    config = {
        bucket  = "mgusek-terraform"
        prefix  = "terraform/${path_relative_to_include()}/state"
        encryption_key = local.encryption_key
        credentials = "/home/micha/google/key.json"
    }
}