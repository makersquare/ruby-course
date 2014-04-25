require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(item, cost)
    @menu_items << Item.new(item, cost)
  end

end

class Item
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end

