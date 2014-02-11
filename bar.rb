require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
  end

  def name
    @name
  end

  def menu_items
    @menu_items
  end

  def add_menu_item(item,price)
    @menu_items << [item,price]
  end
end
