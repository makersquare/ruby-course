require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount, :happy_hour
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0.5
  end
  def add_menu_item(name, price)
    @menu_items.push(Item.new(name, price))
  end

  def happy_discount=(value)
    if value >= 0 && value <= 1
      @happy_discount = value
    elsif value > 1
      @happy_discount = 1
    else
      @happy_discount = 0
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_hour?
    if Time.now.hour == 15
      true
    else
      false
    end
  end

  def get_price(item)
    if happy_hour?
      item.price * @happy_discount
    else
      item.price
    end
  end
end

class Item
attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end



  def get_price
    @price
  end

end







