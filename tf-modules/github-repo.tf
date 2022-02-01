#######################################################################################################################
variable "repository_name" {
  description = "The name of the repository"
}


# Create kubescreen repository
resource "github_repository" "repo" {
  name = var.repository_name
  description = "Deploy and secure a Kubernetes cluster using GitOps."
}

# Add memberships for kube-apps repository
resource "github_team_repository" "repo_name" {
  for_each = {
    for team in local.repo_teams_files["repository_name"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.$(var.reponame).id
  permission = each.value.permission
}

# Set the default branch as "main"
resource "github_branch" "main" {
  repository = github_repository.$(var.reponame).name
  branch     = "main"
}

resource "github_branch_default" "default"{
  repository = github_repository.$(var.reponame).name
  branch     = github_branch.main.branch
}
