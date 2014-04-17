module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      db = Timeline.db
      user = db.get_user(inputs[:user_id])
      return failure(:user_id_not_specified) if user.nil?

      team = db.get_team(inputs[:team_id])
      return failure(:team_id_not_specified) if team.nil?

      return failure(:event_name_not_specified) if inputs[:name].nil?

      success :event => db.create_event(inputs)
    end
  end
end
