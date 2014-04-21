module Timeline
  class CreateEvent < UseCase
    # def run(inputs=nil)
    #   event = Timeline.db.create_event(inputs)
    #   return failure(:event_does_not_exist) if event.nil?


    #   # NOT SHOWN: Modify task to assign to employee

    #   # Return a success with relevant data
    #   success :event => event
    # end

    def run(inputs)
          name = inputs[:name]
          team_id = inputs[:team_id]
          user_id = inputs[:user_id]

          return failure(:no_team_with_that_id) if Timeline.db.get_team(team_id) ==nil
          return failure(:that_user_does_not_exist) if Timeline.db.get_user(user_id) == nil
          return failure(:event_name_not_valid) if name.empty?
          event = Timeline.db.create_event(name: inputs[:name], team_id: inputs[:team_id])

          success(:event=>event)
       #It should error check for user_id, team_id, and blank names.
    end

  end
end

