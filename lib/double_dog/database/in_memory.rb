module DoubleDog
  module Database
    class InMemory

      def initialize
        @users = {}
        @users_id_counter = 100
        @sessions = {}
        @sessions_id_counter = 100
        @items = {}
        @item_id_counter = 500
        @orders = {}
        @order_id_counter = 600
      end

      def create_user(attrs)
        new_id = (@item_id_counter += 1)
        @users[new_id] = attrs
        attrs[:id] = new_id
        build_user(attrs)
      end

      def get_user(id)
        attrs = @users[id]
        build_user(attrs)
      end

      def create_session(attrs)
        new_id = (@sessions_id_counter += 1)
        @sessions[new_id] = attrs
        return new_id
      end

      def get_user_by_session_id(sid)
        return nil if @sessions[sid].nil?
        user_id = @sessions[sid][:user_id]
        user_attrs = @users[user_id]
        build_user(user_attrs)
      end

      def get_user_by_username(username)
        user_attrs = @users.values.find { |attrs| attrs[:username] == username }
        return nil if user_attrs.nil?
        build_user(user_attrs)
      end

      def create_item(attrs)
        new_id = (@item_id_counter += 1)
        @items[new_id] = attrs
        attrs[:id] = new_id
        build_item(attrs)
      end

      def get_item(id)
        attrs = @items[id]
        build_item(attrs)
      end

      def all_items
        @items.values.map do |attrs|
          build_item(attrs)
        end
      end

      def create_order(attrs)
        new_id = (@order_id_counter += 1)
        @orders[new_id] = attrs
        attrs[:id] = new_id
        build_order(attrs)
      end

      def get_order(id)
        attrs = @orders[id]
        build_order(attrs)
      end

      def all_orders
        @orders.values.map do |attrs|
          build_order(attrs)
        end
      end

    private

      def build_user(attrs)
        User.new(attrs[:id], attrs[:username], attrs[:password], attrs[:admin])
      end

      def build_item(attrs)
        Item.new(attrs[:id], attrs[:name], attrs[:price])
      end

      def build_order(attrs)
        Order.new(attrs[:id], attrs[:employee_id], attrs[:items])
      end

    end
  end
end
