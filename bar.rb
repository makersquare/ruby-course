require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(item_name, price)
    @menu_items << {item_name => price}
  end

  def name
    @menu_items.each do |x|
      x.each do |k,v|
        puts k
      end
    end
  end

end

# class Item
#   def initialize(name, price)
#     @name = name
#     @price = price
#   end
# end

