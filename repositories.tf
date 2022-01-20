#######################################################################################################################
# Create github-config repository
resource "github_repository" "github-config" {
  name = "github-config"
}

# Add memberships for github-config repository
resource "github_team_repository" "github-config" {
  for_each = {
    for team in local.repo_teams_files["github-config"] :
    team.team_name => {
      team_id    = github_team.all[team.team_name].id
      permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id    = each.value.team_id
  repository = github_repository.github-config.id
  permission = each.value.permission
}

