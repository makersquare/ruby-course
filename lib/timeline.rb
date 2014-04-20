require 'active_model'
require 'pry-debugger'
require_relative 'timeline/entity'
require_relative 'usecase'
module Timeline
end

# Gem.find_files("timeline/database/*.rb").each { |path| require path }
# Gem.find_files("timeline/entities/*.rb").each { |path| require path }
# Gem.find_files("timeline/usecases/*.rb").each { |path| require path }


require_relative 'timeline/usecases/get_teams'
require_relative 'timeline/database/in_memory.rb'
require_relative 'timeline/database/persistence.rb'

require_relative 'timeline/entities/event.rb'
require_relative 'timeline/entities/team.rb'
require_relative 'timeline/entities/user.rb'

require_relative 'timeline/usecases/create_event.rb'
require_relative 'timeline/usecases/get_team_events.rb'
require_relative 'timeline/usecases/get_teams.rb'

