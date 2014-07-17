module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      team = Timeline.db.get_team inputs[:team_id]
      return failure(:team_does_not_exist) if team.nil?
      begin
        events = Timeline.db.get_events_by_team team.id
        success :events => events
      rescue
        failure :database_error
      end
    end
  end
end
