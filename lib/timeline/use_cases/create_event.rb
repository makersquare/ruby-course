module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      tags = inputs[:tags] || []
      user_id = inputs[:user_id] ? inputs[:user_id].to_i : nil
      user_name = inputs[:user_name]
      team_id = inputs[:team_id].to_i
      if user_id
        user = Timeline.db.get_user user_id
        return failure(:user_does_not_exist) if user.nil?
      elsif user_name
        user = Timeline.db.create_user :name => user_name
      else
        return failure(:user_does_not_exist)
      end
      team = Timeline.db.get_team team_id
      return failure(:team_does_not_exist) if team.nil?
      begin
        event = Timeline.db.create_event({
          :name => inputs[:name],
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
