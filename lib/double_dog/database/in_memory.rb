module DoubleDog
  module Database
    class InMemory

      def initialize
        @items = {}
        @item_id_counter = 100
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
