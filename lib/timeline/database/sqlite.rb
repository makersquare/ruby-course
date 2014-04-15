module Timeline
  module Database
    class InMemory

      def initialize(config=nil)
        clear_everything
      end

      def clear_everything
        @user_id_counter = 100
        @team_id_counter = 500
        @event_id_counter = 800
        @users = {}
        @teams = {}
        @events = {}
      end

      # # # # #
      # Users #
      # # # # #

      def create_user(attrs)
        id = (@user_id_counter += 1)
        attrs[:id] = id
        User.new(attrs).tap {|user| @users[id] = user }
      end

      def get_user(id)
        @users[id]
      end

      def all_users
        @users.values
      end

      # # # # #
      # Teams #
      # # # # #

      def create_team(attrs)
        id = (@team_id_counter += 1)
        attrs[:id] = id
        Team.new(attrs).tap {|team| @teams[id] = team }
      end

      def get_team(id)
        @teams[id]
      end

      def all_teams
        @teams.values
      end

      ## # # # #
      # Events #
      # # # # ##

      def create_event(attrs)
        id = (@event_id_counter += 1)
        attrs[:id] = id
        attrs[:created_at] ||= Time.now

        Event.new(attrs).tap {|event| @events[id] = event }
      end

      def get_event(id)
        @events[id]
      end

      def get_events_by_team(team_id)
        @events.select {|id,event| event.team_id == team_id }.values.sort_by {|e| e.created_at }
      end

    end
  end
end
