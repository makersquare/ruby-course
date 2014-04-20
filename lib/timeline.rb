require 'active_model'

module Timeline
	def self.db
		@__db_instance ||= Database::InMemory.new(@app_db_name)
	end

	def self.db_name=(db_name)
		@app_db_name = db_name
	end

	def self.seed_db
		
	end
end

require_relative 'timeline/entity.rb'
require_relative 'timeline/usecases/usecase.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
Gem.find_files("timeline/usecases/*.rb").each { |path| require path }
