require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_reader :menu_items
  attr_reader :happy_discount

  def initialize(name)
    @menu_items = []
    @name = name
    @happy_discount = 0
  end

  def happy_hour?
    if Time.now.hour == 15
      return true
    else
      return false
    end
  end

  def add_menu_item(name, price)
    @menu_items << Menu_Item.new(name,price)
  end

  def happy_discount=(discount)
    if discount >=1
      @happy_discount = 1
    elsif discount <= 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end


end

class Menu_Item
  attr_reader :name
  attr_reader :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
