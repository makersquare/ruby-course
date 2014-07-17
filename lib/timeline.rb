require 'active_model'

module Timeline
end

require_relative 'timeline/entity.rb'
require_relative 'timeline/use_case.rb' 

Gem.find_files(File.join(__dir__, "timeline/database/") + "*.rb").each { |path| require path }
Gem.find_files(File.join(__dir__, "timeline/entities/") + "*.rb").each { |path| require path }
Gem.find_files(File.join(__dir__, "timeline/use_cases/") + "*.rb").each { |path| require path }

module Timeline
  def self.db
    @__db_instance ||= Database::SqliteDatabase.new   # configures default db
  end

  def self.seed_db
    db.clear_everything
    user1 = db.create_user :name => 'Alice'
    user2 = db.create_user :name => 'Bob'
    user3 = db.create_user :name => 'Carol'
    user4 = db.create_user :name => 'David'
    team1 = db.create_team :name => 'Pirates'
    team2 = db.create_team :name => 'Tigers'
    team3 = db.create_team :name => 'Mets'
    team4 = db.create_team :name => 'Yankees'
    event1 = db.create_event :name => 'superbowl', :team_id => team1.id, :user_id => user1, :tags => ['wacky hat day', 'arbor day']
    event2 = db.create_event :name => 'superbowl XXI', :team_id => team1.id, :user_id => user3, :tags => ['festivus', 'no refunds']
    event3 = db.create_event :name => 'world series', :team_id => team2.id, :user_id => user4, :tags => ['fumigating', 'free hot dogs']
  end
end
