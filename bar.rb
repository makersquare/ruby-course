require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount
  def initialize(name)
    @name = name
    @menu_items = []
  end
  def add_menu_item(name, price)
    @menu_items.push(Item.new(name, price))
  end
  def happy_discount(discount=0)
    discount
  end
end


class Item
attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
