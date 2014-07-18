require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @happy_hour = 15
  end

  def add_menu_item(name, price)
    @menu_items << Item.new(name, price)
  end

  def happy_discount
    return @happy_discount if happy_hour?
    0
  end
  
  def happy_discount=(discount)
    return @happy_discount = 1 if discount > 1
    return @happy_discount = 0 if discount < 0
    @happy_discount = discount
  end

  def happy_hour?
    Time.now.hour == @happy_hour ? true : false
  end

  def get_price(name)
    price = @menu_items.select do |item|
       item.name == name
    end.pop.price
    price - price*happy_discount
  end

end

class Item
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
