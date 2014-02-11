require 'time' # you're gonna need it

class Bar
attr_reader :name
attr_accessor :menu_items, :happy_discount, :menu_items_hash

  def initialize(name, menu_items = nil, happy_discount = 0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
    @menu_items_hash = {}
  end

  def add_menu_item(name, price)
    @menu_items_hash.store(name, price)
    item = Drink.new(name, price)
    @menu_items.push(item)
  end

  def happy_discount=(value)
    if value < 1 && value > 0
      @happy_discount = value
    elsif value > 1
      @happy_discount = 1
    elsif value < 0
      @happy_discount = 0
    end
  end

  def happy_hour?
    if (Time.now.hour >= 15 and Time.now.hour <= 16)
      true
    else
      false
    end
  end

  def get_price(drink)
    if happy_hour?
      return @menu_items_hash[drink].to_f * 0.5
    else
      return @menu_items_hash[drink]
    end
  end

end


class Drink
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
