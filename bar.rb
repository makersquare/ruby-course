require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :item, :cost, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item, cost)
    new_item = MenuItems.new(item, cost)
    @menu_items << new_item
  end

  def happy_hour?
  end

  def happy_discount
    if happy_hour? == true
      @happy_discount
    else
      0
    end
  end
end

class MenuItems
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
