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
        Event.destroy_all
        Tag.destroy_all
      end

      # Define models and relationships here (yes, classes within a class)
      class User < ActiveRecord::Base
        has_many :events # wasn't there before
      end

      class Team < ActiveRecord::Base
        has_many :events
      end

      class Event < ActiveRecord::Base
        has_many :tags

        belongs_to :team
      end

      class Tag < ActiveRecord::Base
        belongs_to :event
      end

      class Timestamp < ActiveRecord::Base
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
        tag_names_arr = attrs[:tags] || []

        attrs_without_tags = attrs.clone
        attrs_without_tags.delete(:tags)

        ar_event = Event.create(attrs_without_tags)

        # create the tags in the db and associate them with the event
        tag_names_arr.each do |tag_name|
          ar_event.tags.create(name: tag_name)
        end

        # because ar_event.attributes by itself does not have tags
        # we are adding a tags key and value
        # note that we can't change ar_event.attributes hash itself
        # the merge method creates a clone that merges in a new key value pairs
        #
        ar_event_attrs_with_tags = ar_event.attributes.merge({:tags => tag_names_arr})

        Timeline::Event.new(ar_event_attrs_with_tags)
      end

      def get_event(eid)
        ar_event = Event.find(eid)
        tag_names_arr = ar_event.tags.map { |tag| tag.name }

        ar_event_attrs_with_tags = ar_event.attributes.merge({:tags => tag_names_arr})
        # ar_event_attrs_with_tags = ar_event.attributes.clone
        # ar_event_attrs_with_tags[:tags] = tag_names_arr

        Timeline::Event.new(ar_event_attrs_with_tags)
      end

      def create_timestamp
        ar_time = Timestamp.create(name: "something")
      end

      def get_events_by_team(tid)
        ar_team = Team.find(tid)
        ar_events = ar_team.events.order("created_at ASC")
      end
    end
  end
end
