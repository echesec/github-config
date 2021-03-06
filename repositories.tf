#######################################################################################################################
# Create kubescreen repository
resource "github_repository" "shields-up" {
  name = "shields-up"
  description = "Deploy and secure a Kubernetes cluster using GitOps."
}

# Add memberships for repository
resource "github_team_repository" "shields-up" {
  for_each = {
    for team in local.repo_teams_files["shields-up"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.shields-up.id
  permission = each.value.permission
}


#######################################################################################################################
# Create payments repository
resource "github_repository" "payments" {
  name = "payments"
  description = "Python app to test and demo CI."
}

# Add memberships for payments repository
resource "github_team_repository" "payments" {
  for_each = {
    for team in local.repo_teams_files["payments"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.payments.id
  permission = each.value.permission
}


#######################################################################################################################
# Create cluster-policies repository
resource "github_repository" "cluster-policies" {
  name = "cluster-policies"
  description = "Kyverno enforcement policies."
}

# Add memberships for kube-apps repository
resource "github_team_repository" "cluster-policies" {
  for_each = {
    for team in local.repo_teams_files["cluster-policies"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.cluster-policies.id
  permission = each.value.permission
}

