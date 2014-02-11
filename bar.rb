require 'time' # you're gonna need it

class Bar
  attr_reader :name, :happy_discount, :happy_hour
  attr_accessor :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items << MenuItem.new(name, price)
  end

  def happy_discount=(discount)
    if discount < 0
      @happy_discount = 0
    elsif discount > 1
      @happy_discount = 1
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    time = Time.now
    if time.hour >= 15 && time.hour <= 16
      return true
    else
      return false
    end
  end

  def get_price(name)
    @menu_items.each do |item|
      # if name == item.name
      if item.name == name
        if self.happy_hour? == true
          return item.price * self.happy_discount
        else
          return item.price
        end
      end
    end
  end
end


class MenuItem
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
