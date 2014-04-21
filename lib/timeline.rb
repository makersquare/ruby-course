require 'active_model'

module Timeline
	def self.db
    @db ||= Database::InMemory.new
  end

	# def self.db
	# 	@__db_instance ||= Database::InMemory.new(@app_db_name)
	# end

	# def self.db_name=(db_name)
	# 	@app_db_name = db_name
	# end

	def self.seed_db
		db.create_user(name: "Jose")
		db.create_user(name: "Drew")
		db.create_user(name: "Chris")

		db.create_team(name: "Dream Team")
		db.create_team(name: "All Stars Team")
		db.create_team(name: "Bad Team")

		db.create_event(user_id: 1, team_id: 1, name: "x" )
		db.create_event(user_id: 2, team_id: 1, name: "y" )
		db.create_event(user_id: 1, team_id: 2, name: "z" )
		db.create_event(user_id: 3, team_id: 1, name: "a" )
		db.create_event(user_id: 2, team_id: 3, name: "b" )
  end

  # def self.config_db(db_class)
  #   @db_class = db_class
  # end
end

require_relative 'timeline/entity.rb'
require_relative 'timeline/usecases/usecase.rb'

# Gem.find_files("timeline/database/*.rb").each { |path| require path }
# Gem.find_files("timeline/entities/*.rb").each { |path| require path }
# Gem.find_files("timeline/usecases/*.rb").each { |path| require path }

Dir["#{File.dirname(__FILE__)}/timeline/database/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/timeline/entities/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/timeline/usecases/*.rb"].each { |f| require(f) }
