require 'active_model'

module Timeline
  def self.db
    @db ||= Database::InMemory.new
  end

  def self.seed_db
    50.times { db.create_team({name: rand(9999).hash.to_s}) }
    50.times { db.create_user({name: rand(9999).hash.to_s}) }
    50.times { db.create_event({user_id: rand(50), team_id: rand(50), name: rand(9999).hash.to_s })}
  end
end

require_relative 'timeline/entity.rb'
require_relative 'usecase.rb'

Gem.find_files("timeline/database/*.rb").each { |path| require path }
Gem.find_files("timeline/entities/*.rb").each { |path| require path }
Gem.find_files("timeline/usecases/*.rb").each { |path| require path }
