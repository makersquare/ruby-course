require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item)
    @menu_items << item
  end

end

class MenuItem
  attr_reader :name
  attr_reader :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
