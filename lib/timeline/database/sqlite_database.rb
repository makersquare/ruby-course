require 'active_record'

module Timeline
  module Database

    class SQLiteDatabase

      def initialize
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'timeline-test.db'
        )
      end

      # Define models and relationships here (yes, classes within a class)
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

      # Now implement you database methods here

      def clear_everything
        User.delete_all
        Team.delete_all
        Event.delete_all
        Tag.delete_all
      end

      # # # # #
      # Users #
      # # # # #

      def create_user(attrs)
        # NOTE the difference between the two `User` classes.
        # The first inherits from ActiveRecord, while
        # the second is your app's entity class
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      def get_user(id)
        # user = User.find(id)
        Timeline::User.new(User.find(id).attributes)
      end

      def all_users
        users = User.all
      end

      # # # # #
      # Teams #
      # # # # #

      def create_team(attrs)
        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      def get_team(id)
        # team = Team.find(id)
        Timeline::Team.new(Team.find(id).attributes)
      end

      def all_teams
        teams = Team.all
      end

      ## # # # #
      # Events #
      # # # # ##

      def create_event(attrs)
        # puts "ATTRS: #{attrs}"
        tags = attrs[:tags]
        attrs.delete(:tags)
        ar_event = Event.create(attrs)
        event = Timeline::Event.new(ar_event.attributes)
        event.tags = []
          if tags != nil
            tags.each do |tag|
              Tag.create( { event_id: ar_event.id, name: tag } )
            end
          end
        event
      end

      def get_event(id)
        event = Event.find(id)
        event_tags = event.tags
       
        Timeline::Event.new({ id: event.id, name: event.name, tags: event_tags.map { |tag| tag.name }})
      end

      def get_events_by_team(team_id)
        team = Team.find(team_id)
        team.events.sort_by(&:created_at)
      end

      # # # # #
      # Tags  #
      # # # # #

      # def create_tag(attrs)
      #   ar_tag = Tag.create(attrs)
      #   Timeline::Tag.new(ar_tag.attributes)
      # end

      # def get_tag(id)
      #   tag = Tag.find(id)
      #   binding.pry
      #   # Timeline::Event.new(Event.find(id).attributes)
      # end

    end
  end
end
