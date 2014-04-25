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
    @menu_items << Item.new(item, price)
  end

  def happy_hour?
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
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
