module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      team_id = inputs[:team_id]
      return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) == nil
      return failure(:team_has_no_events) if Timeline.db.get_events_by_team(team_id) == []
      events = Timeline.db.get_events_by_team(team_id)
      success(:event=>events)
    end
  end
end

# def run(inputs)
#       name = inputs[:name]
#       team_id = inputs[:team_id]

#       return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) ==nil
#       event = Timeline.db.create_event(name: inputs[:name], team_id: inputs[:team_id])

#       success(:event=>event)
   #It should error check for user_id, team_id,
