require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def name
    @name
  end

  def menu_items
    @menu_items
  end

  def add_menu_item(item,price)
    @menu_items << Item.new(item,price)
  end

  def happy_discount
    if @happy_discount >= 1
      1
    elsif @happy_discount > 0
       @happy_discount
    else
      0
    end
  end

end

class Item
  attr_accessor :name, :price
  def initialize (name,price)
    @name = name
    @price = price
  end

  def name
    @name
  end
end
