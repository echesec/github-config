#######################################################################################################################
# Create kubescreen repository
resource "github_repository" "kubescreen" {
  name = "kubescreen"
  description = "Deploy and secure a Kubernetes cluster using GitOps."
}

# Add memberships for kube-apps repository
resource "github_team_repository" "kubescreen" {
  for_each = {
    for team in local.repo_teams_files["kubescreen"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.kubescreen.id
  permission = each.value.permission
}

# Set the default branch as "main"
resource "github_branch" "main" {
  repository = github_repository.kubescreen.name
  branch     = "main"
}

resource "github_branch_default" "default"{
  repository = github_repository.kubescreen.name
  branch     = github_branch.main.branch
}




#######################################################################################################################
# Create foo repository
resource "github_repository" "foo" {
  name = "foo"
  description = "Deploy and secure a Kubernetes cluster using GitOps."
}

# Add memberships for kube-apps repository
resource "github_team_repository" "foo" {
  for_each = {
    for team in local.repo_teams_files["foo"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.foo.id
  permission = each.value.permission
}

# Set the default branch as "main"
resource "github_branch" "main" {
  repository = github_repository.foo.name
  branch     = "main"
}

resource "github_branch_default" "default"{
  repository = github_repository.foo.name
  branch     = github_branch.main.branch
}