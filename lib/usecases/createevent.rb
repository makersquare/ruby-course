module Timeline
  class CreateEvent  < UseCase
    def run(inputs)

      user_id = inputs[:user_id]
      user = Timeline.db.get_user(user_id)

      return failure(:missing_user) if user.nil?

      team_id = inputs[:team_id]
      team = Timeline.db.get_team(team_id)

      return failure(:missing_team) if team.nil?

      attrs = {user_id: user_id, team_id: team_id, name: inputs[:name], content: inputs[:content], tags: [inputs[:tags]]}
      event = Timeline.db.create_event(attrs)

      success :event => event

    end
  end
end

