module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      @db = Timeline.db
      user = @db.get_user(inputs[:user_id])
      team = @db.get_team(inputs[:team_id])
      name = inputs[:name]
      # binding.pry
      # This will return failure if user does not exist
      return failure(:invalid_user) if user.nil?

      # This will return failure if team does not exist
      return failure(:invalid_team) if team.nil?

      # This will return failure if the name is left blank
      return failure(:invalid_name) if inputs[:name] == "" || inputs[:name].nil?

      # Return a success with relevant data
      event = @db.create_event({user_id: user.id, team_id: team.id, name: name})
      success(event: event)
    end
  end
end