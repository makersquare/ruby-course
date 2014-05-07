require 'active_record'
require 'yaml'

module Timeline
  module Database
    class SqliteDatabase
      def initialize
        dbconfig = YAML::load_file(File.join(__dir__, '../../../db/config.yml'))
        dbconfig.each do |key, value|
          value['database'] = File.join(__dir__, '../../../',  value['database'])
        end
        ActiveRecord::Base.establish_connection(dbconfig['test'])  # adapter not found for some reason
      end
      
      def clear_everything
        [User, Team, Event, Tag].each {|model| model.delete_all }
      end

      ## # # # # # #
      # All Models #
      # # # # # # ##

      class User < ActiveRecord::Base
        has_many :events
      end

      class Team < ActiveRecord::Base
        has_many :events
      end

      class Event < ActiveRecord::Base
        attr_accessor :created_at
        belongs_to :user
        belongs_to :team
        has_many :tags
      end

      class EventTag < ActiveRecord::Base
        belongs_to :event
        belongs_to :tag
      end

      class Tag < ActiveRecord::Base
        has_many :events
      end

      # # # # #
      # Users #
      # # # # #

      def create_user(attrs)
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      def get_user(id)
        ar_user = User.find(id)
        Timeline::User.new(ar_user.attributes)
      end

      def all_users
        User.all.map {|ar_user| Timeline::User.new(ar_user.attributes)}
      end

      # # # # #
      # Teams #
      # # # # #

      def create_team(attrs)
        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      def get_team(id)
        ar_team = Team.find(id)
        Timeline::Team.new(ar_team.attributes)
      end

      def all_teams
        Team.all.map { |ar_team| Timeline::Team.new(ar_team.attributes) }
      end

      ## # # # #
      # Events #
      # # # # ##

      def create_event(attrs)
        # Grab tag names
        tag_names = attrs.delete(:tags) || []

        # Create event first
        ar_event = Event.create(attrs)

        # Create tags and attach to event
        tag_names.each do |tag_name|
          ar_tag = Tag.find_or_create_by :name => tag_name
          ar_event.tags << ar_tag
        end

        event_attrs = ar_event.attributes.merge :tags => tag_names
        # event_attrs[:created_at] = event_attrs[:created_at].to_i
        Timeline::Event.new(event_attrs)
      end

      def get_event(id)
        ar_event = Event.find(id)
        event_attrs = ar_event.attributes.merge :tags => ar_event.tags.map(&:name)
        Timeline::Event.new(event_attrs)
      end

      def get_events_by_team(team_id)
        ar_events = Event.where(:team_id => team_id).order(:created_at)
        ar_events.collect do |ar_event|
          event_attrs = ar_event.attributes.merge :tags => ar_event.tags.map(&:name)
          Timeline::Event.new(event_attrs)
        end
      end
    end
  end
end