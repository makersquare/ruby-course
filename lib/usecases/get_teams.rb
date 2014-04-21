module Timeline
  class GetTeams < UseCase
    def run(inputs=nil)
      teams = Timeline.db.all_teams
      success(teams: teams)
    end
  end
end
