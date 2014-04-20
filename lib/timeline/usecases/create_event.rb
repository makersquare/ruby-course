require 'pry-debugger'

module Timeline
  class CreateEvent < UseCase
    def run(inputs)
      return failure(:no_user_id) if inputs[:user_id].nil?
      return failure(:no_team_id) if inputs[:team_id].nil?
      return failure(:no_name_given) if inputs[:name].nil?
      @db = Timeline.db
      event = @db.create_event(:name => inputs[:name], :user_id => inputs[:user_id], :team_id => inputs[:team_id])
      success :event => event
    end
  end
end
