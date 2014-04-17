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
    # should be the same as in the yaml file
  end


   def clear_everything
      User.destroy_all
      Team.destroy_all
      Event.destroy_all
      Tag.destroy_all

    end
  # Define models and relationships here (yes, classes within a class)
  class User < ActiveRecord::Base
    belongs_to :team
  end

  class Team < ActiveRecord::Base
    has_many :users
  end

  class Event <ActiveRecord::Base
    has_many :teams
  end

  class Tag <ActiveRecord::Base
    belongs_to :event
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

# x = get_user(1)
# x.update(name: "bob")

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

  def all_teams
    teams = Team.all
    rendered_teams= []
    teams.each do |x|
      new_team = Timeline::Team.new(x.attributes)
      rendered_teams << new_team
    end

    rendered_teams
  end


  def create_event(attrs)
    tags_array = attrs[:tags]
    attrs.delete(:tags)
    ar_event = Event.create(attrs)
    event = Timeline::Event.new(ar_event.attributes)
    event.tags = []
    if tags_array != nil
    tags_array.each do |x|
      event.tags.push(x)
      Tag.create( {name: x, event_id: ar_event.id } )
    end
  end
    hash_tag = {:tags => tags_array}

    event
  end

  def get_event(event_id)

    event = Event.find(event_id)
    event_tags = event.tags.all


    event_entity = Timeline::Event.new(event.attributes)
    event.attributes.tags = event_tags
    event_entity

  end

end
