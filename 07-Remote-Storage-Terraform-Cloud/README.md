You have now seen how to build, change, and destroy infrastructure from a local machine. This is great for testing and development, but in production environments it is more responsible to share responsibility for infrastructure. The best way to do this is by running Terraform in a remote environment with shared access to state.

### Terraform Cloud

configure the token in %APPDATA% for windows and ~/ for linux [more information](https://www.terraform.io/docs/commands/cli-config.html)


add config for remote in the main .tf file

terraform {
  backend "remote" {
    organization = "jlrm-org"

    workspaces {
      name = "Dev-2"
    }
  }
}

