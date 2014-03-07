require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items
  attr_writer :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item, price)
    new_item = Item.new(item, price)
    @menu_items << new_item
  end

  def happy_hour?
    time = Time.now
    if time.hour >= 15 && time.hour <= 16
      true
    else
      false
    end
  end

  def happy_discount
    return @happy_discount if self.happy_hour?
    0
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

end

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
