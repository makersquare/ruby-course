require 'time' # you're gonna need it
require 'pry'

class Bar
  attr_reader :name, :happy_discount
  attr_accessor :menu_items

  def initialize(name, menu_items=[], happy_discount = 0)
    @name = name
    @menu_items = menu_items
    @happy_discount = happy_discount
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
    t = Time.now.hour
    if t >= 15 && t < 16
      # alternatively, just t == 15. Thanks Gilbert!
      true
    else
      false
    end
  end

  def get_price(drink_name)
    case self.happy_hour?
    when true
      @menu_items.select { |item| item.name == drink_name }.first.price*0.5
    else
      @menu_items.select { |item| item.name == drink_name }.first.price
    end
  end

  def add_menu_item(name, price)
    item = Item.new(name, price)
    @menu_items << item
  end
end

class Item
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end