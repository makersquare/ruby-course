require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    new_item = Item.new(name, price)
    @menu_items << new_item
  end

  def happy_discount=(value)
    if value < 0
      @happy_discount = 0
    elsif value > 1
      @happy_discount = 1
    else
      @happy_discount = value
    end
  end

  def happy_hour?
    t = Time.now
    if t.hour >= 15 && t.hour <= 16
      return true
    else
      return false
    end
  end

  def get_price(name)
    @menu_items.each do |item|
      if name == item.name
        if self.happy_hour? == true
          return item.price * self.happy_discount
        else
          return item.price
        end
      else
        return nil
      end
    end
  end

end

class Item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
