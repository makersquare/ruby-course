require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_hour
  attr_writer :happy_discount

  def initialize(name, menu_items=[], happy_discount=0.0)
    @name = name
    @menu_items = menu_items
    @happy_discount = happy_discount
    @happy_hour = false
  end

  def add_menu_item(item, cost)
    drink = Item.new(item, cost)
    @menu_items << drink
  end

  def happy_discount
    return 0 if !happy_hour?

    if @happy_discount > 1
      @happy_discount = 1
    elsif @happy_discount < 0
      @happy_discount = 0
    else
      @happy_discount
    end
  end

  def happy_hour?(this_second=Time.now)
    #this_second = Time.now
    if this_second.hour <= 16 && this_second.hour >= 15
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
