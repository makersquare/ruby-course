module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      name = inputs[:name]
      user_id = inputs[:user_id].to_i

      verify_user = Timeline.db.get_user(user_id)
      return failure(:user_doesnt_exist) if verify_user.nil?
      team_id = inputs[:team_id].to_i
      verify_team = Timeline.db.get_team(team_id)
      return failure(:team_doesnt_exist) if verify_team.nil?


      event = Timeline.db.create_event(inputs)
      success(event: event)
    end
  end
end
