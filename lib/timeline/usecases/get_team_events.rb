module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
     
      team_id = inputs[:team_id]
      team = Timeline.db.get_team(team_id)
      return failure(:missing_team) if team.nil?

      events = Timeline.db.get_events_by_team(team_id)
      success(events: events)
    end
  end
end