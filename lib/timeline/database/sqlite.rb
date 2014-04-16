require 'active_record'
require 'yaml'

module Timeline
  module Database
    class SQLite
      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'ar-ex_test'
          )
        # configs = YAML.load_file('db/config.yml')
        # ActiveRecord::Base.establish_connection(configs[test])
      end

      class User < ActiveRecord::Base
        has_many :events
      end

      class Team < ActiveRecord::Base
        has_many :events
      end

      class Event < ActiveRecord::Base
        belongs_to :user
        belongs_to :team
        has_many :tags
      end

      class Tag < ActiveRecord::Base
        belongs_to :event
      end

      def clear_everything
        User.delete_all
        Team.delete_all
        Tag.delete_all
        Event.delete_all
      end

      # Users
      def create_user(attrs)
        user = User.create(name: attrs[:name])
        Timeline::User.new({id: user.id, name: user.name})
      end

      def get_user(id)
        user = User.find(id)
        Timeline::User.new({id: user.id, name: user.name})
      end

      def all_users
        users = User.all
        array = []
        users.each do |user|
          array.push(Timeline::User.new({id: user.id, name: user.name}))
        end
        array
      end

      # Teams
      def create_team(attrs)
        team = Team.create(name: attrs[:name])
        Timeline::Team.new({id: team.id, name: team.name})
      end

      def get_team(id)
        team = Team.find(id)
        Timeline::Team.new({id: team.id, name: team.name})
      end

      def all_teams
        teams = Team.all
        array = []
        teams.each do |team|
          array.push(Timeline::Team.new({id: team.id, name: team.name}))
        end
        array
      end

      # Events
      def create_event(attrs)
        event = Event.create(name: attrs[:name], user_id: attrs[:user_id], team_id: attrs[:team_id], content: attrs[:content], created_at: Time.now)

        attrs[:tags].each {|tag| Tag.create(tag: tag, event_id: event.id)} if attrs[:tags]
        Timeline::Event.new({id: event.id, name: event.name, user_id: event.user_id, team_id: event.team_id, content: event.content, created_at: event.created_at, tags: attrs[:tags]})
      end

      def get_event(id)
        event = Event.find(id)
        Timeline::Event.new({id: event.id, name: event.name, user_id: event.user_id, team_id: event.team_id, content: event.content, created_at: event.created_at, tags: get_tags_for_event(event.id)})
      end

      def get_events_by_team(team_id)
        events = Event.where(team_id: team_id)
        array = []
        events.each do |event|
          array.push(Timeline::Event.new({id: event.id, name: event.name, user_id: event.user_id, team_id: event.team_id, content: event.content, created_at: event.created_at, tags: get_tags_for_event(event.id)}))
        end
        array.sort { |a,b| a.created_at <=> b.created_at }
      end

      def get_tags_for_event(event_id)
        tags = Tag.where(event_id: event_id)
        array = []
        tags.each do |tag|
          array.push(tag.tag)
        end
        array
      end
    end
  end
end
