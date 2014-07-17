require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :happy_discount

  def initialize(name)
    @name=name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items << MenuItem.new(name, price)
  end

end

class MenuItem
  attr_reader :name, :price
  
  def initialize(name, price)
    @name = name
    @price = price
  end
end