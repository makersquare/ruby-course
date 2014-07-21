require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :happy_discount, :happy_hour

  def initialize(name, happy_discount=0, happy_hour=false)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
    @happy_hour = happy_hour
  end

  def add_menu_item(item, price)
    @menu_items << Item.new(item, price)
  end

  def happy_discount
    if happy_hour? == false
      return 0
    else
      if @happy_discount > 1
        return 1
      elsif @happy_discount < 0
        return 0
      else
        return @happy_discount
      end 
    end
  end

  def happy_hour?
    time = ((Time.now.hour * 60) + Time.now.min)
    if time >= 900 && time <= 960
      happy_discount = true
      true
    else 
      happy_discount = false
      false
    end
  end

  def get_price(price)
    if happy_hour? == true
      return "$#{"%.2f" % (price/2.00)}"
    else 
      return "$#{"%.2f" % price}"
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
