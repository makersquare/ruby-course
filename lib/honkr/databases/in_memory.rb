module Honkr
  module Databases
    class InMemory

      def initialize
        @honks = {}
        @honks_counter = 0
        @users = {}
        @users_counter = 0
      end

      def persist_honk(honk)
        new_id = (@honks_counter += 1)
        attrs = {
          :id => new_id,
          :user_id => honk.user_id,
          :content => honk.content
        }
        # Save the new honk data in the database (in this case, a hash)
        @honks[new_id] = attrs

        # Add the new id to the honk object
        honk.instance_variable_set("@id", new_id)
      end

      def get_honk(id)
        attrs = @honks[id]
        Honk.new(attrs[:id], attrs[:user_id], attrs[:content])
      end

      def persist_user(user)
        new_id = (@users_counter += 1)
        attrs = {
          :id => new_id,
          :username => user.username,
          :password_digest => user.password_digest
        }
        # Save the new user data in the database (in this case, a hash)
        @users[new_id] = attrs

        # Add the new id to the user object
        user.instance_variable_set("@id", new_id)
      end

      def get_user(id)
        attrs = @users[id]
        User.new(attrs[:id], attrs[:username], attrs[:password])
      end

      # def get_user_by_username(username)
      #   attrs = @user[username]
      #   User.new(attrs[:id], attrs[:username], attrs[:password])
      # end

      # def create_session(user_id: user_id)
      #   return @user_id
      # end
    end
  end
end