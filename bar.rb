require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :slow_day_happy_discount

  def initialize(name)
    @name=name
    @menu_items = []
    @happy_discount = 0
    @slow_day_happy_discount = 0
  end

  def add_menu_item(name, price, hhstatus = false)
    @menu_items << MenuItem.new(name, price, hhstatus)
  end

  def happy_discount=(x)
    x = 0 if x < 0
    x = 1 if x > 1
    @happy_discount = x
  end

  def happy_discount
    return 0 unless happy_hour?
    slow_day? ? @slow_day_happy_discount : @happy_discount
  end

  def happy_hour?
    this_hour = Time.now.hour 
    this_hour == 15 ? true : false
  end

  def get_price(item)
    return item.price unless item.hhstatus
    (item.price * (1 - happy_discount)).round(2)
  end

  def slow_day?
    return true if Time.now.monday?
    return true if Time.now.wednesday?
    false
  end

end

class MenuItem
  attr_reader :name, :price, :hhstatus
  
  def initialize(name, price, hhstatus = false )
    @name = name
    @price = price
    @hhstatus = hhstatus
  end
end