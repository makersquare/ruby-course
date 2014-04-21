require 'active_model'
require 'active_record'
require 'active_record_tasks'
require 'pry-debugger'

require_relative 'usecase.rb'
require_relative 'usecase/create_event.rb'
require_relative 'usecase/get_team_events.rb'
require_relative 'usecase/get_teams.rb'

module Timeline
  def self.db
    @db_instance ||= Database::InMemory.new

  end

  def self.seed_db
    # team_1 = self.db.create_team(name: "Great team")
    # team_2 = self.db.create_team(name: "okay team")
    # user = self.db.create_user(name: "Hubert")
    # event = self.db.create_event(name: "Sun god", user_id: user.id, team_id: team_1.id )
    self.db.clear_everything
    team_1 = self.db.create_team(name: "Cool Team")
    team_2 = self.db.create_team(name: "Shitty TEam")
    team_3 = self.db.create_team(name: "good looking team")
    user = self.db.create_user(name: "Hubert")
    event1 = self.db.create_event(name: "Sun god", user_id: user.id, team_id: team_1.id )
    event2 = self.db.create_event(name: "Sleepathon", user_id: user.id, team_id: team_1.id )
    event3 = self.db.create_event(name: "Study all week", user_id: user.id, team_id: team_1.id )
    event4 = self.db.create_event(name: "hackathon", user_id: user.id, team_id: team_2.id )
    event5 = self.db.create_event(name: "final project", user_id: user.id, team_id: team_3.id )
  end

end




require_relative 'timeline/entity.rb'
  require_relative 'usecase.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }

Dir["#{File.dirname(__FILE__)}/timeline/database/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/timeline/entities/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/timeline/use_cases/*.rb"].each { |f| require(f) }
