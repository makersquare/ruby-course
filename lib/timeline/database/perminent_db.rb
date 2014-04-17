
module Timeline
  module Database
    class SQLite

      def initialize
        # configs = YAML.load_file('db/config.yml')
        # puts "CONFIG: #{configs}"
        # ActiveRecord::Base.establish_connection(
        #   configs['test']
        # )
        ActiveRecord::Base.establish_connection(
          :adapter => 'sqlite3',
          :database => 'ar-ex_test'
        )
      end

      def clear_everything
        User.destroy_all
        Team.destroy_all
      end

      class Team < ActiveRecord::Base
        has_many :users
        has_many :events
      end

      class User < ActiveRecord::Base
        has_many :events
      end

      class Event < ActiveRecord::Base
        belongs_to :user
        belongs_to :team
        has_many :tags
      end

      class Tag < ActiveRecord::Base
        belongs_to :events
      end


      # # # # #
      # Users #
      # # # # #

      def create_user(attrs)
        ar_user = User.create(attrs)
        Timeline::User.new(ar_user.attributes)
      end

      def get_user(user_id)
        ar_user =User.find(user_id)
        Timeline::User.new(ar_user.attributes)
      end

      def all_users
        ar_users = User.all
        ar_users.map do |user|
          Timeline::User.new(user.attributes)
        end
      end

      def create_team(attrs)
        ar_team = Team.create(attrs)
        Timeline::Team.new(ar_team.attributes)
      end

      def get_team(team_id)
        ar_team = Team.find(team_id)
        Timeline::Team.new(ar_team.attributes)
      end

      def all_teams
        ar_teams = Team.all
        ar_teams.map do |team|
          Timeline::Team.new(team.attributes)
        end
      end

      def create_event(attrs)

        tags = attrs.delete(:tags)
        ar_event = Event.create(attrs)
        if tags != nil
          tags.each do |tag|
            Tag.create(
                content: tag,
                event_id: ar_event.id
              )
          end
        else
          tags = []
        end
        event = Timeline::Event.new( ar_event.attributes.merge({tags: tags}) )
        event
      end

      def get_event(event_id)
        ar_event = Event.find(event_id)
        ar_tags = ar_event.tags
        Timeline::Event.new({
          :id => ar_event.id,
          :name => ar_event.name,
          :tags => ar_tags.map{|fuck| fuck.content}
          })
      end

      def get_events_by_team(team_id)
        ar_team = Team.find(team_id)
        events = ar_team.events
        events = events.sort_by(&:created_at)
        events.map {|event| get_event(event.id)}
      end


# x.update(name: "whoever")

    end
  end
end
