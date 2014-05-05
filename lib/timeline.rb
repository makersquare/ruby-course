require 'active_model'

module Timeline
end

require_relative 'timeline/entity.rb'
require_relative 'timeline/use_case.rb' 

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
Gem.find_files("timeline/use_cases/*.rb").each { |path| require path }


module Timeline
  def self.db
    @__db_instance ||= Database::SqliteDatabase.new   # configures default db
  end
end
