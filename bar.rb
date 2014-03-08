require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(name, price)
    new_item = MenuItem.new(name, price)
    @menu_items << new_item
  end



end

class MenuItem

  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end


