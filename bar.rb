require 'time' # you're gonna need it

class Bar
  attr_reader :name
  def initialize(name)
    @name = name
  end
  def menu_items
    @items = []
  end
  def add_menu_item(item_name, price)

  end
end
