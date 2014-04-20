module Timeline
  class GetTeamEvents < UseCase
    def run(inputs)
      return failure(:no_team_id) if inputs[:team_id].nil?
      @db = Timeline.db
      team = @db.get_team(inputs[:team_id])
      events = @db.get_events_by_team(inputs[:team_id])
      success :events => events, :team => team
    end
  end
end
