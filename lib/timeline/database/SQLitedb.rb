require 'yaml'
require 'active_record'
require 'pry-debugger'
# dbconfig = YAML::load(File.open('db/config.yml'))
# ActiveRecord::Base.establish_connection(dbconfig)
module Timeline
  module Database
  class SQLiteDatabase

  def initialize
    ActiveRecord::Base.establish_connection(
      :adapter => 'sqlite3',
      :database => 'ar-ex_test'
    )
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

  class Event < ActiveRecord::Base
    has_many :teams
    has_many :tags
  end

  class Tag < ActiveRecord::Base
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
    Timeline::User.new(User.find(id).attributes)
  end

  def all_users
    users = User.all
    returned_users = []
    users.each do |x|
      new_user = Timeline::User.new(x.attributes)
      returned_users << new_user
    end
    return returned_users
  end

  def create_team(attrs)
    team = Team.create(attrs)
    Timeline::Team.new(team.attributes)
  end

  def get_team(id)
    Timeline::Team.new(Team.find(id).attributes)
  end

  def all_teams
    teams = Team.all
    returned_teams = []
    teams.each do |x|
      new_team = Timeline::Team.new(x.attributes)
      returned_teams << new_team
    end
    return returned_teams
  end

  def create_event(attrs)
   tags_array = attrs[:tags]
   attrs.delete(:tags)
   ar_event = Event.create(attrs)
   event = Timeline::Event.new(ar_event.attributes)
   event.tags = []
    if tags_array != nil
      tags_array.each do |x|
        Tag.create( {name: x, event_id: ar_event.id } )
      end
    end

   hash_tag = {:tags => tags_array}
   event
 end

 def get_event(event_id)

   event = Event.find(event_id)
   event_tags = event.tags

   tag_array = []

   if event_tags != nil
    event_tags.each do |x|
      tags =x.name
      tag_array << tags
    end
  end
   event_entity = Timeline::Event.new(event.attributes.merge(:tags => tag_array))
 end


  def get_events_by_team(team_id)
    event = Event.where(:team_id => team_id)
    event.sort_by(&:created_at)
  end

  end
end
end
