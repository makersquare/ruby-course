module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      name = inputs[:name]
      team_id = inputs[:team_id]

      return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) ==nil
      event = Timeline.db.create_event(name: inputs[:name], team_id: inputs[:team_id])

      success(:event=>event)
   #It should error check for user_id, team_id, and blank names.
    end
  end
end

 # accname = inputs[:accname]
 #    password = inputs[:password]



 #    return failure(:name_taken) if Rps.db.get_user_by_name(accname) !=nil

 #    user = Rps.db.sign_up_user(inputs[:accname],inputs[:password])
 #    success(:user=> user)
