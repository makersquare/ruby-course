require 'time' # you're gonna need it

class Bar
attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(food, price)
    @menu_items.push(Item.new(food,price))
  end

  def happy_hour?
    return true if Time.now.hour == 15
    false
  end

  def happy_discount=(new_discount)
    if new_discount > 1
      @happy_discount = 1
    elsif new_discount < 0
      @happy_discount = 0
    else
      @happy_discount = new_discount
    end
  end


  def happy_discount
      return @happy_discount if self.happy_hour?
      0
  end
end

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
