require 'time' # you're gonna need it

class Bar

  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    new_item = Menu_Item.new(name, price)
    @menu_items << new_item
  end

  def happy_discount
    if self.happy_hour?
      return @happy_discount
    else
      return 0
    end
  end

  def happy_discount=(happy_discount)
    if (happy_discount > 1)
      @happy_discount = 1
    elsif (happy_discount < 0)
      @happy_discount = 0
    else
      @happy_discount = happy_discount
    end
  end

  def happy_hour?
    if (Time.now.hour < 16) && (Time.now.hour >= 15)
      return true
    end
    return false
  end

  def ring_up_item(item)  # takes an item and returns current price
    item.price - (item.price * happy_discount)
  end







end

class Menu_Item
  attr_accessor :name
  attr_accessor :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
