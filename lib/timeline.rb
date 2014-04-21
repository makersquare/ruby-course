require 'active_model'
require 'yaml'
require 'active_record'
require 'active_record_tasks'
require 'pry-debugger'

module Timeline
  def self.db
    @___db_instance ||= Timeline::Database::InMemory.new
  end
end

require 'timeline/entity.rb'
require 'use_case.rb'
require 'timeline/use_cases/create_event.rb'
require 'timeline/use_cases/get_team_events.rb'
require 'timeline/use_cases/get_teams.rb'


Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
