provider "github" {}

# Retrieve information about the currently (PAT) authenticated user
data "github_user" "self" {
  username = ""
}

data "github_team" "security" {
  slug = "security"
}

data "github_team" "developers" {
  slug = "developers"
}

data "github_team" "operations" {
  slug = "operations"
}
