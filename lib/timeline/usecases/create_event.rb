module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      user = InMemory.get_user(inputs[:user_id])
      team = InMemory.get_team(inputs[:team_id])
      name = inputs[name]

      # This will return failure if user does not exist
      return failure(:invalid_user) if user.nil?

      # This will return failure if team does not exist
      return failure(:invalid_team) if user.id.nil?

      # This will return failure if the name is left blank
      return failure(:invalid_name) if name == "" || name == nil

      # Return a success with relevant data
      success :user => user
    end
  end
end