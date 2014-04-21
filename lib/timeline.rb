require 'active_model'
require 'active_record'
require 'yaml'
require 'pry-debugger'

module Timeline
	def self.db
		@__db ||= Timeline::Database::InMemory.new
	end

	def self.seed_db
		user1 = db.create_user(name: "Antonio")
		user2 = db.create_user(name: "J. Braden")
		user3 = db.create_user(name: "Moiz")
		user3 = db.create_user(name: "Alfred E. Newman")

		team1 = db.create_team(name: "MakerSquare")
		team2 = db.create_team(name: "DevHouse")
		team3 = db.create_team(name: "Blazers")
		team3 = db.create_team(name: "Rockets")

		event1 = db.create_event(name: "Event 1", team_id: team1.id, user_id: user1.id)
		event2 = db.create_event(name: "Event 2", team_id: team2.id, user_id: user2.id)
		event3 = db.create_event(name: "Event 3", team_id: team3.id, user_id: user3.id)
	end
end

require_relative 'timeline/entity.rb'
require_relative 'timeline/database/activerecord.rb'
require_relative 'use_case.rb'
require_relative 'timeline/use-cases/create_event.rb'
require_relative 'timeline/use-cases/see_all_events_by_team.rb'
require_relative 'timeline/use-cases/get_teams.rb'

require_relative 'timeline/database/activerecord.rb'
require_relative 'timeline/database/in_memory.rb'
require_relative 'timeline/entities/event.rb'
require_relative 'timeline/entities/tag.rb'
require_relative 'timeline/entities/team.rb'
require_relative 'timeline/entities/user.rb'

# Gem.find_files("timeline/database/*.rb").each { |path| require path }
# Gem.find_files("timeline/entities/*.rb").each { |path| require path }
