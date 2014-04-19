module Timeline
  class GetTeams < UseCase
    def run(inputs)
      teams = Timeline.db.all_teams

      success :teams => teams
    end
  end
end
