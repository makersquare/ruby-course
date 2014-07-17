module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      name = inputs[:name]
      user_id = inputs[:user_id]
      return failure(:no_user_id_provided) if user_id.nil?
      verify_user = Timeline.db.get_user(user_id)
      return failure(:user_doesnt_exist) if verify_user.nil?
      team_id = inputs[:team_id]
      return failure(:no_team_id_provided) if team_id.nil?
      verify_team = Timeline.db.get_team(team_id)
      return failure(:team_doesnt_exist) if verify_team.nil?
      event = Timeline.db.create_event(inputs)
      success(event: event)
    end
  end
end
