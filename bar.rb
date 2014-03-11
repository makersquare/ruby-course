require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(name,price)
    @menu_items << (Item.new(name,price))
  end

  def happy_discount
    0
  end

end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price

  end
end
