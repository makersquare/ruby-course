module Timeline
  class GetTeamEvents < UseCase
    def run(inputs=nil)

      team_id = inputs[:team_id]
      team = Timeline.db.get_team(team_id)
      return failure(:team_does_not_exist) if team.nil?

      # NOT SHOWN: Modify task to assign to employee

      # Return a success with relevant data
      events = Timeline.db.get_events_by_team(team_id)
      success :events => events

    end
  end
end

