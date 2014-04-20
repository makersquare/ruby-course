module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      name = inputs[:name]
      content = inputs[:content]
      user_id = inputs[:user_id]
      team_id = inputs[:team_id]
      return failure(:no_name_given) if inputs[:name].nil?
      verify_user = Timeline.db.get_user(user_id)
      return failure(:invalid_user_id) if verify_user.nil?
      verify_team = Timeline.db.get_team(team_id)
      return failure(:invalid_team_id) if verify_team.nil?
      event = Timeline.db.create_event(inputs)
      success :event => event
    end
  end
end


