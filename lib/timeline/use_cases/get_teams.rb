module Timeline
  class GetTeams < UseCase
    def run(inputs)
      begin
        teams = Timeline.db.all_teams
        success :teams => teams
      rescue
        failure :database_error
      end
    end
  end
end
