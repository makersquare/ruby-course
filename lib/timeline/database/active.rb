require 'yaml'
require 'active_record'

module Timeline
  module Database
    class Active
      def initialize
      yamlShit = YAML.load_file("db/config.yml")
          ActiveRecord::Base.establish_connection(
            yamlShit["test"]
          )
      end

      def clear_everything
        User.delete_all
        Event.delete_all
        Team.delete_all
        Tag.delete_all
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

      def create_user(attr)
        ar_user = User.create(name: attr[:name])
        entity_user = Timeline::User.new(ar_user.attributes)
        return entity_user
      end

      def get_user(user_id)
        ar_user = User.find(user_id)
        entity_user = Timeline::User.new(ar_user.attributes)
        return entity_user
      end

      def all_users
        users = User.all()
        entity_users = users
      end

      def create_team(attr)
        ar_team = Team.create(name: attr[:name])
        entity_team = Timeline::Team.new(ar_team.attributes)
        return entity_team
      end

      def get_team(team_id)
        ar_team = Team.find(team_id)
        entity_team = Timeline::Team.new(ar_team.attributes)
        return entity_team
      end

      def all_teams
        teams = Team.all()
        entity_team = teams
      end

      def create_event(attr)
        ar_event = Event.create(name: attr[:name], team_id: attr[:team_id])
        tags = attr[:tags]
        entity_event = Timeline::Event.new(ar_event.attributes)
        entity_event.tags = []
        if tags != nil
          entity_event.tags = tags
          tags.map do |tag|
            Tag.create(tag: tag, event_id: entity_event.id)
          end
        end
        return entity_event
      end

      def get_event(event_id)
        ar_event = Event.find(event_id)
        entity_event = Timeline::Event.new(ar_event.attributes)
        entity_event.tags = []
        tags = Tag.where(event_id: entity_event.id)
        if (tags != nil)
          tags.map do |tag|
            entity_event.tags << tag.tag
          end
        end
        return entity_event
      end

      def get_events_by_team(team_id)
        ar_events = Event.where(team_id: team_id).order("created_at ASC")
        entity_events = []
        ar_events.each do |event|
          event = Timeline::Event.new(event.attributes)
          entity_events << event
        end
        return entity_events
      end
    end
  end
end
