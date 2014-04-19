require 'active_model'

module Timeline
  def self.db
    if @db_class == "sqlite3"
      @db = Database::SQLite.new
    else
      @db ||= Database::InMemory.new
    end
  end

  def self.seed_db
    50.times { db.create_team({name: rand(9999).hash.to_s}) }
    50.times { db.create_user({name: rand(9999).hash.to_s}) }
    500.times { db.create_event({user_id: rand(50), team_id: rand(50), name: rand(9999).hash.to_s })}
  end

  def self.config_db(db_class)
    @db_class = db_class
  end
end

require_relative 'timeline/entity.rb'
require_relative 'usecase.rb'

require_relative 'timeline/database/in_memory.rb'
require_relative 'timeline/database/sqlite.rb'

require_relative 'timeline/entities/event.rb'
require_relative 'timeline/entities/team.rb'
require_relative 'timeline/entities/user.rb'

require_relative 'timeline/usecases/create_event.rb'
require_relative 'timeline/usecases/get_team_events.rb'
require_relative 'timeline/usecases/get_teams.rb'



