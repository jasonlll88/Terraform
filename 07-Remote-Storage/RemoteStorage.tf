terraform {
  backend "remote" {
    organization = "jlrm-org"

    workspaces {
      name = "Dev/QA"
    }
  }
}