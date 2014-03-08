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
    new_item = MenuItem.new(name, price)
    @menu_items << new_item
  end

  def happy_hour?
    if (Time.now.hour > 15) && (Time.now.hour < 17)  #between 3pm & 5pm
      return true
    else
      return false
    end
  end

  def happy_discount
    if self.happy_hour?
      return (@happy_discount)
    else
      return 0
    end
  end


  def happy_discount=(discount)
    if (discount > 1)
      @happy_discount = 1
    elsif (discount < 0)
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def current_price(item)
    if self.happy_hour?
      return item.price - (item.price * @happy_discount)
    else
      return item.price
    end
  end
end  #end Class Bar

class MenuItem

  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end


