require 'active_model'

module Timeline
  def self.db
    @__db_instance ||= Database::InMemory.new
  end
end

require 'timeline/entity.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
# Gem.find_files("usecases/*.rb").each { |path| require path }
require_relative 'timeline.rb'
require_relative 'usecase.rb'
require_relative 'usecases/createevent.rb'
require_relative 'usecases/getteamevents.rb'
