module DoubleDog
  module Database
    class InMemory

      def initialize
        @users = {}
        @users_id_counter = 100
        @items = {}
        @item_id_counter = 500
      end

      def create_user(attrs)
        new_id = (@item_id_counter += 1)
        @users[new_id] = attrs
        attrs[:id] = new_id
        User.new(attrs[:id], attrs[:username], attrs[:password])
      end

      def get_user(id)
        attrs = @users[id]
        User.new(attrs[:id], attrs[:username], attrs[:password])
      end

      def create_item(attrs)
        new_id = (@item_id_counter += 1)
        @items[new_id] = attrs
        attrs[:id] = new_id
        Item.new(attrs[:id], attrs[:name], attrs[:price])
      end

      def get_item(id)
        attrs = @items[id]
        Item.new(attrs[:id], attrs[:name], attrs[:price])
      end

      def all_items
        @items.values.map do |attrs|
          Item.new(attrs[:id], attrs[:name], attrs[:price])
        end
      end

    end
  end
end
