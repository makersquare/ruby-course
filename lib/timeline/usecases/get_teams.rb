module Timeline
  class GetTeams < UseCase
    def run(inputs)
      @db = Timeline.db
      teams = Timeline.db.all_teams
      success :teams => teams
    end
  end
end
