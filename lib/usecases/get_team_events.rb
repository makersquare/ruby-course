module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      team_id = inputs[:team_id]
      verify_team = Timeline.db.get_team(team_id)
      return failure(:team_doesnt_exist) if verify_team.nil?
      events = Timeline.db.get_events_by_team(team_id)
      success(events: events)
    end
  end
end
