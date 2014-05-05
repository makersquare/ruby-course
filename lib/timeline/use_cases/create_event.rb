module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      tags = inputs[:tags] || []
      user = Timeline.db.get_user inputs[:user_id]
      return failure(:user_does_not_exist) if user.nil?
      team = Timeline.db.get_team inputs[:team_id]
      return failure(:team_does_not_exist) if team.nil?
      begin
        event = Timeline.db.create_event({
          :name => inputs[:name],
          :created_at => Time.now,
          :user_id => user.id,
          :team_id => team.id,
          :tags => tags
        })
        success :event => event
      rescue
        failure :database_error
      end
    end
  end
end
