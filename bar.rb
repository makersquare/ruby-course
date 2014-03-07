require 'time' # you're gonna need it

class Bar
attr_reader :name, :menu_items
attr_accessor :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(food, price)
    @menu_items.push(Item.new(food,price))
  end
end

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
