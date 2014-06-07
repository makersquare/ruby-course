require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    item = Menu_item.new(name, price)
    @menu_items << item
  end

  def happy_discount=(discount)
    @happy_discount = discount
  end
end

class Menu_item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end