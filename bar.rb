require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    item = Menu_item.new(name, price)
    @menu_items << item
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

  def happy_discount=(discount)
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end
end

class Menu_item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end