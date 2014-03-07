require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
  end
  def add_menu_item(name, price)
    @menu_items.push(Item.new(name, price))
  end

  def happy_discount=(value)
    if  value >= 0 && value <= 1
      @happy_discount = value
    elsif value > 1
      @happy_discount = 1
    elsif value < 0
      @happy_discount = 0
    end
  end

  def happy_discount
    if happy_hour == true
      @happy_discount
    else
      0
    end
  end

  def happy_hour
      current_time = Time.now.hour
      if current_time >= 16 && current_time <= 16.59
        true
      else
        false
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
