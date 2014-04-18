require 'active_model'

module Timeline
  def self.db
    @__db ||= Timeline::Database::InMemory.new
  end
  def self.seed_db
    @__DB__ = Timeline::Database::Active.new
    u1 = @__DB__.create_user(name: 'frank')
    u2 = @__DB__.create_user(name: 'juanita')
    u3 = @__DB__.create_user(name: 'carlos')
    u4 = @__DB__.create_user(name: 'becky')

    t1 = @__DB__.create_team(name: 'buttholes')
    t2 = @__DB__.create_team(name: 'team2')
    t3 = @__DB__.create_team(name: 'team3')
    t4 = @__DB__.create_team(name: 'team4')

    e1 = @__DB__.create_event(name: 'bulky buttholes', user_id: u1.id, team_id: t1.id)
    e1 = @__DB__.create_event(name: 'e2', user_id: u2.id, team_id: t2.id)
    e1 = @__DB__.create_event(name: 'e3', user_id: u3.id, team_id: t3.id)
    e1 = @__DB__.create_event(name: 'e4', user_id: u4.id, team_id: t4.id)

  end
end

require 'timeline/entity.rb'
require 'use_case.rb'
require 'usecases/create_event.rb'
require 'usecases/get_teams.rb'
require 'usecases/get_team_events.rb'


Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
