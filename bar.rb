require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_hour?

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item_name, price)
    item = Item.new(item_name, price)
    @menu_items << item
  end

  def happy_discount

    if :happy_hour? == true
      @happy_discount = 0.5
    else

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

