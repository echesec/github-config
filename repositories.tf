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
