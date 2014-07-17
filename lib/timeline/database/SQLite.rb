require 'active_record'

module Timeline
  module Database
    class SQLite

      def initialize()
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
        ActiveRecord::Base.subclasses.each(&:destroy_all)

      end

      # # # # # # # # #
      # # User Crud # #
      # # # # # # # # #
      def get_user(id)
        User.find(id)
      end

      def all_users
        User.all
      end

      def create_user(attrs)
        # NOTE the difference betwee the two `User` classes.
        # The first inherits from ActiveRecord, while
        # the second is your app's entity class
        # binding.pry
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      # # # # # # # # #
      # # Team Crud # #
      # # # # # # # # #
      def get_team(id)
        Team.find(id)
      end

      def all_teams
        Team.all
      end

      def create_team(attrs)
        # NOTE the difference betwee the two `User` classes.
        # The first inherits from ActiveRecord, while
        # the second is your app's entity class
        # binding.pry

        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      # # # #  # # # # #
      # # Event Crud # #
      # # # # #  # # # #
      def get_event(id)
        event = Event.find(id)
        thoseTags = event.tags
        newTags = thoseTags.map{|tag| tag.content}
        newHash = event.attributes.merge(tags: newTags)

        rubyEvent = Timeline::Event.new(newHash)
      end



      def get_events_by_team(team_id)
        events = Event.where(team_id: team_id)
        array = []
        events.each do |event|
          array.push(get_event(event.id))
        end
        array.sort { |a,b| a.created_at <=> b.created_at }
      end

      def all_events
        Event.all
      end

      def create_event(attrs)
        # NOTE the difference betwee the two `User` classes.
        # The first inherits from ActiveRecord, while
        # the second is your app's entity class
        # binding.pry

        tag_names_arr = attrs[:tags] || []

        attrs_without_tags = attrs.clone
        attrs_without_tags.delete(:tags)

        ar_event = Event.create(attrs_without_tags)

        # create the tags in the db and associate them with the event
        # binding.pry
        tagContArray = []
        tag_names_arr.each do |tag|
          ar_event.tags.create(content: tag)
          # tagContArray << tag[]
        end



        event_hash = {
          id: ar_event.id,
          user_id: ar_event.user_id,
          team_id: ar_event.team_id,
          name: ar_event.name,
          content: ar_event.content,
          created_at: ar_event.created_at,
          tags: tag_names_arr
        }

        event_entity = Timeline::Event.new(event_hash)
        event_entity
      end

    end
  end
end
