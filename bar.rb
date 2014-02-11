require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    new_item = Item.new(name, price)
    @menu_items << new_item
  end

  def happy_discount=(value)
    if value < 0
      @happy_discount = 0
    elsif value > 1
      @happy_discount = 1
    else
      @happy_discount = value
    end
  end

end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
