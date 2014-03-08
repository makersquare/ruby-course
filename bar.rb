require 'time' # you're gonna need it

class Bar
attr_reader :name, :menu_items
attr_writer :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name,price)
    @menu_items.push(Item.new(name,price))
  end

  def happy_hour?
    return true if Time.now.hour == 15
    false
  end

  def happy_discount
    return @happy_discount if self.happy_hour?
    0
  end

  def happy_discount=(discount)
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end
end


class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
