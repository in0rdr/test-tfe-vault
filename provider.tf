provider "vault" {
  address            = var.vault_address
  add_address_to_env = true
  auth_login {
    path = "auth/userpass/login/${var.vault_username}"
    parameters = {
      password = var.vault_password
    }
  }
}

resource "vault_mount" "kv" {
  path                      = "testme"
  type                      = "kv-v2"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "agruhler-test"

    workspaces {
      name = "test-tfe-vault"
    }
  }
}