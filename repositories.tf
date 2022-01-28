#######################################################################################################################
# Create kube-core repository
resource "github_repository" "argocd" {
  name = "kube-core"
  description = "Helm and Kustomize manifests to deploy ArgoCD to Kubernetes."
}

# Add memberships for kube-apps repository
resource "github_team_repository" "kube-core" {
  for_each = {
    for team in local.repo_teams_files["kube-core"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.kube-core.id
  permission = each.value.permission
}
