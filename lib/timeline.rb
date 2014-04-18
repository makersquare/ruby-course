require 'active_model'

module Timeline
	def self.db
		@__db_instance ||= InMemory.new #(@app_db_name)
	end

	# def self.db_name=(db_name)
	# 	@app_db_name = db_name
	# end
end

require 'timeline/entity.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
