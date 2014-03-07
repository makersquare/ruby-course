require 'time' # you're gonna need it

class Bar

  attr_reader :name
  attr_accessor :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    new_item = Menu_Item.new(name, price)
    @menu_items << new_item
  end

end

class Menu_Item
  attr_accessor :name
  attr_accessor :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
