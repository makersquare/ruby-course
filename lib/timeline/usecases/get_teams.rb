module Timeline
  class GetTeams < UseCase
    def run(inputs=nil)
      @db = Timeline.db
      teams = @db.all_teams

      return failure(:no_teams_in_database) if teams.empty?

      success(teams: teams)
    end
  end
end