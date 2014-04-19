module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      db = Timeline.db
      team = db.get_team(inputs[:team_id])
      return failure(:team_does_not_exist) if team.nil?

      events = db.get_events_by_team(team.id)

      success :events => events, :team => team
    end
  end
end
