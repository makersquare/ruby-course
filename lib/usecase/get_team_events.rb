module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      team_id = inputs[:id].to_i
      return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) == nil
      return failure(:team_has_no_events) if Timeline.db.get_events_by_team(team_id) == []
      events = Timeline.db.get_events_by_team(team_id)
      team = Timeline.db.get_team(team_id)
      success(events:events, team:team)
    end
  end
end

# module Timeline
#   class GetTeamEvents < UseCase
#     def run(inputs)
#       # binding.pry
#       inputs[:team_id] = inputs[:team_id]

#       team = Timeline.db.get_team(inputs[:team_id])
#       return failure(:missing_team) if team.nil?

#       events = Timeline.db.get_events_by_team(inputs[:team_id])
#       success(team: team, events: events)
#     end
#   end
# end
