require "active_record"
require "yaml"
module Timeline
  module Database
    class SQLiteDatabase
      def initialize
        dbconfig = YAML::load(File.open('db/config.yml'))
        ActiveRecord::Base.establish_connection(dbconfig["test"])
      end

      # Define models and relationships here (yes, classes within a class)
      class User < ActiveRecord::Base
        has_many :events
      end

      class Event < ActiveRecord::Base
        belongs_to :user
        belongs_to :team
        has_many :tasks
      end

      class Team < ActiveRecord::Base
        has_many :events
      end

      class Tag < ActiveRecord::Base
        belongs_to :event
      end

      def clear_everything
      User.delete_all
      Team.delete_all
      Event.delete_all
      Tag.delete_all
      end
      # Now implement you database methods here

      def create_user(attrs)
        # NOTE the difference betwee the two `User` classes.
        # The first inherits from ActiveRecord, while
        # the second is your app's entity class
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      def create_team(attrs)
        ar_user = Team.create(attrs)
        Timeline::Team.new(ar_user.attributes)
      end

      def get_team(id)
        team = Team.find(id)
        team = Timeline::Team.new(team.attributes)
        team
      end

      def all_teams
         teams = Team.all
        returned_teams = []
        teams.each do |x|
          team = Timeline::Team.new(x.attributes)
          returned_teams.push(team)
        end
        returned_teams
      end

      def all_events
         events = Event.all
        returned_events = []
        events.each do |x|
          event = Timeline::Event.new(x.attributes)
          returned_events.push(event)
        end
        returned_events
      end

      def create_event(attrs)
        event = Event.create(name: attrs[:name], user_id: attrs[:user_id], team_id: attrs[:team_id], content: attrs[:content], created_at: Time.now)

        attrs[:tags].each {|tag| Tag.create(tag: tag, event_id: event.id)} if attrs[:tags]
        Timeline::Event.new({id: event.id, name: event.name, user_id: event.user_id, team_id: event.team_id, content: event.content, created_at: event.created_at, tags: attrs[:tags]})
      end

      def get_event(id)
        event = Event.find(id)
        tags = Tag.where(event_id: id)
        array = []
        tags.each do |tag|
          array.push(tag.tag)
        end
        Timeline::Event.new({id: event.id, name: event.name, user_id: event.user_id, team_id: event.team_id, content: event.content, created_at: event.created_at, tags: array})
      end

      def get_user(id)
        user = User.find(id)
        user = Timeline::User.new(user.attributes)
        user
      end

      def all_users
        users = User.all
        returned_users = []
        users.each do |x|
          user = Timeline::User.new(x.attributes)
          returned_users.push(user)
        end
        returned_users
      end

      def get_events_by_team(team_id)
          team = Team.find(team_id)
          events = team.events
          event_array = []
          events.each do |x|
            event = Timeline::Event.new(x.attributes)
            event_array.push(event)
          end
        event_array.sort_by {|e| e.created_at }
      end
    end
  end
end
