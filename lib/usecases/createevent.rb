module Timeline
  class CreateEvent  < UseCase
    def run(inputs)

      user = @db.get_user(inputs[:user_id])
      return failure(:missing_uid) if user_id.nil?



      team = @db.create_team(inputs[:team_attrs])


      event = @db.create_event(inputs[:attributes])
      success :event =>event


    end
  end
end

