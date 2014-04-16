module Timeline
  module Database
    class SQLiteDB

      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'ar-ex_test'
        )
      end

      def clear_everything
        User.destroy_all
        Team.destroy_all
      end

      # Define models and relationships here (yes, classes within a class)
      class User < ActiveRecord::Base
      end

      class Team < ActiveRecord::Base
      end

      class Event < ActiveRecord::Base
      end

      # Now implement you database methods here

      def create_user(attrs)
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      def get_user(uid)
        ar_user = User.find(uid)
        Timeline::User.new(ar_user.attributes)
      end

      def all_users
        ar_users = User.all
        ar_users.map do |ar_user|
          Timeline::User.new(ar_user.attributes)
        end
      end

      def create_team(attrs)
        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      def get_team(tid)
        ar_team = Team.find(tid)
        Timeline::Team.new(ar_team.attributes)
      end

      def all_teams
        ar_teams = Team.all
        ar_teams.map do |ar_team|
          Timeline::Team.new(ar_team.attributes)
        end
      end

      def create_event(attrs)
        ar_event = Event.create(attrs)
        Timeline::Event.new(ar_event.attributes)
      end
    end
  end
end