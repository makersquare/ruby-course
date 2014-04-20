require 'active_model'

module Timeline
  def self.db
    @__db ||= Timeline::Database::InMemory.new
  end
  def self.seed_db
    # @__DB__ = Timeline::Database::Active.new
    u1 = db.create_user(name: 'frank')
    u2 = db.create_user(name: 'juanita')
    u3 = db.create_user(name: 'carlos')
    u4 = db.create_user(name: 'becky')

    t1 = db.create_team(name: 'team1')
    t2 = db.create_team(name: 'team2')
    t3 = db.create_team(name: 'team3')
    t4 = db.create_team(name: 'team4')

    e1 = db.create_event(name: 'e1', user_id: u1.id, team_id: t1.id)
    e1 = db.create_event(name: 'e2', user_id: u2.id, team_id: t2.id)
    e1 = db.create_event(name: 'e3', user_id: u3.id, team_id: t3.id)
    e1 = db.create_event(name: 'e4', user_id: u4.id, team_id: t4.id)

  end
end



# Gem.find_files("timeline/database/*.rb").each { |path| require path }
# Gem.find_files("timeline/entities/*.rb").each { |path| require path }
require_relative 'timeline/database/active.rb'
require_relative 'timeline/database/in_memory.rb'
require_relative 'timeline/entity.rb'
require_relative 'timeline/entities/event.rb'
require_relative 'timeline/entities/team.rb'
require_relative 'timeline/entities/user.rb'
require_relative 'use_case.rb'
require_relative 'usecases/get_teams.rb'
require_relative 'usecases/create_event.rb'
require_relative 'usecases/get_team_events.rb'
