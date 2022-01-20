#######################################################################################################################
# Create teleport repository
resource "github_repository" "teleport" {
  name = "teleport"
}

# Add memberships for kube-apps repository
resource "github_team_repository" "teleport" {
  for_each = {
    for team in local.repo_teams_files["teleport"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.teleport.id
  permission = each.value.permission
}
