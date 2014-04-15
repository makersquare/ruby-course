require 'active_record'

module Timeline
  module Database
    class SQLite
      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'ar-ex_test'
          )
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
      end

      # Teams
      def create_team(attrs)
      end

      def get_team(id)
      end

      def all_teams
      end

      # Events
      def create_event(attrs)
      end

      def get_event(id)
      end

      def get_events_by_team(team_id)
      end
    end
  end
end
