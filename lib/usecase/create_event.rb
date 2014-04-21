module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      name = inputs[:name]
      team_id = inputs[:team_id].to_i
      user_id = inputs[:user_id].to_i
      return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) ==nil
      return failure(:that_user_does_not_exist) if Timeline.db.get_user(user_id) == nil
      return failure(:event_name_not_valid) if name.empty?
      event = Timeline.db.create_event(name: inputs[:name], team_id: inputs[:team_id])

      success(:event=>event)
   #It should error check for user_id, team_id, and blank names.
    end
  end
end



