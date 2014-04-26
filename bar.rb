require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :item, :cost, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(item, cost)
    new_item = MenuItems.new(item, cost)
    @menu_items << new_item
  end

  def happy_hour?
    if Time.now.class != 'hello'.class || (Time.now < '3 pm' || Time.now > '4 pm')
      false
    else
      true
    end
  end

  def happy_discount=(x)
    if x < 1 && x > 0
      @happy_discount = x
    elsif x < 0
      @happy_discount = 0
    else
      @happy_discount = 1
    end
  end

  def happy_discount
    if happy_hour? == false
      0
    else
      @happy_discount
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
