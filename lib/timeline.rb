require 'active_model'
require 'pry-debugger'
require 'active_record'
require 'active_record_tasks'

require_relative 'usecase.rb'
require_relative 'timeline/usecases/createEvent.rb'
require_relative 'timeline/usecases/getTeams.rb'
require_relative 'timeline/usecases/getTeamEvents.rb'

module Timeline
  def self.db
    @__db_instance ||= Database::InMemory.new
  end
end


require 'timeline/entity.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
