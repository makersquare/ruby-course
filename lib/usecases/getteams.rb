module Timeline
  class GetTeams  < UseCase
    def run(inputs=nil)

      # team_id = inputs[:team_id]
      # team = Timeline.db.get_team(team_id)


      teams = Timeline.db.all_teams
      return failure(:missing_team) if teams.empty?


      success :teams =>teams
    end
  end
end
