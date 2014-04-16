require 'yaml'
require 'active_record'

# dbconfig = YAML::load(File.open('db/config.yml'))
# ActiveRecord::Base.establish_connection(dbconfig)

class SQLiteDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'ar-ex_test'
 )
  end


   def clear_everything
      User.destroy_all
    end
  # Define models and relationships here (yes, classes within a class)
  class User < ActiveRecord::Base
    belongs_to :team
  end

  class Team < ActiveRecord::Base
    has_many :user
  end

  class Event <ActiveRecord::Base
    has_many :teams
  end

  # Now implement you database methods here

  def create_user(attrs)
    # NOTE the difference betwee the two `User` classes.
    # The first inherits from ActiveRecord, while
    # the second is your app's entity class
    ar_user = User.create(attrs)
    Timeline::User.new(ar_user.attributes)
  end

  def get_user(id)
    ar_user= User.find(id)
    Timeline::User.new(ar_user.attributes)
  end

  def all_users
    ar_users = User.all
    rendered_users =  []
    ar_users.each do |x|
      new_user= Timeline::User.new(x.attributes)
      rendered_users << new_user
    end
    rendered_users
  end

  def create_team(attrs)
    team = Team.create(attrs)
    Timeline::Team.new(team.attributes)
  end
  def get_team(id)
    team = Team.find(id)
    Timeline::Team.new(team.attributes)
  end


end
