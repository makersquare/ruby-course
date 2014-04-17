require 'active_model'
require 'active_record'
require 'active_record_tasks'
require 'pry-debugger'

require_relative 'usecase.rb'
require_relative 'usecase/create_event.rb'
require_relative 'usecase/get_team_events.rb'

module Timeline
  def self.db
    @db_instance ||= Database::InMemory.new
  end

end

require 'timeline/entity.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
