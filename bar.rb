require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(item, cost)
    @menu_items << [item, cost]
  end
end
