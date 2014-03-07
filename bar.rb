require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end
  def add_menu_item(name, price)
    @menu_items.push(Item.new(name, price))
  end

  def happy_discount=(value)
   if  value >= 0 && value <= 1
    @happy_discount = value
  elsif value <= 0
    @happy_discount = 0
  else
    @happy_discount = 1
  end
end

  def happy_discount
    if :happy_hour == false
        @happy_discount = 0

    elsif :happy_hour? == true
        @happy_discount
  end
  @happy_discount
end

  def happy_hour
    current_time = Time.now
    if Current_time
  end
end


class Item
attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
