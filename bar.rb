require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_reader :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(dish, price)
    @menu_items << [ dish, price ]
  end

end
