require 'active_model'

module Timeline
  def self.db
    @db ||= Database::InMemory.new
  end
end

require 'timeline/entity.rb'
require 'usecase.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
Gem.find_files("timeline/usecases/*.rb").each { |path| require path }
