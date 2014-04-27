require 'time' # you're gonna need it

class Bar
 attr_reader :name
 attr_accessor :menu_items, :happy_discount, :happy_hour

 def initialize(name, menu_items=0)
  @name = name
  @menu_items = []
  @happy_discount = 0
 end

 def add_menu_item(name, price)
  item = MenuItems.new(name, price)
  @menu_items << item
 end

 def happy_hour?
  if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm")
    return true
  else
    return false
  end
 end

 def happy_discount
  if happy_hour?
   return @happy_discount
  else
   return 0
  end
 end

 def happy_discount=(discount)
    if discount >= 0 && discount <= 1
      @happy_discount = discount
      return @happy_discount
    elsif discount > 1
      @happy_discount = 1
    else
      @happy_discount = 0
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
