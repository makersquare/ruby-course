require 'active_record'

module Timeline
  module Database
    class PersistentDB

      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'ar-ex_test'
        )
      end

      # Define models and relationships here (yes, classes within a class)
      class User < ActiveRecord::Base
        has_many :posts
      end

      class Event < ActiveRecord::Base
        belongs_to :user
        has_many :tags
      end

      class Tag < ActiveRecord::Base
        belongs_to :event
      end

      class Team < ActiveRecord::Base
        has_many :users
        has_many :events
      end

    	def clear_everything
        User.delete_all
        Team.delete_all
        Event.delete_all
    	end

    	def create_user(attrs)
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
    	end


      def get_user(id)
        ar_user = User.find(id)
        Timeline::User.new(ar_user.attributes)
      end

      def all_users
        ar_users = User.all
      end

      def create_event(attrs)
        tags = attrs.delete(:tags)
        ar_event = Event.create(attrs)
        if tags
          tags.each do |tag|
            Tag.create(
              :content => tag,
              :event_id => ar_event.id
              )
          end
        end

        ar_event.attributes[:tags] = tags
        Timeline::Event.new(ar_event.attributes)
        new_event = Timeline::Event.new(ar_event.attributes)
        new_event.tags = tags
        return new_event
      end

      def get_event(id)
        ar_event = Event.find(id)
        tags = ar_event.tags.map {|ar_tag| ar_tag.content }
        Timeline::Event.new({
            :id => ar_event.id,
            :name => ar_event.name,
            :tags => tags
            })
      end

      def create_team(attrs)
        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      def get_team(id)
        ar_team = Team.find(id)
        Timeline::Team.new(ar_team.attributes)
      end

      def all_teams
        all_teams = Team.all
      end

      def get_events_by_team(team_id)
        team = Team.find(team_id)
        team.events.sort_by &:created_at
      end
    end
	end
end