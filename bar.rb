require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(dish, price)
    new_item = Item.new(dish,price)
    @menu_items << new_item
  end

  def happy_discount=(value)
    if value > 1
      @happy_discount = 1
    elsif value < 0
      @happy_discount = 0
    else
      @happy_discount = value
    end
  end

  def happy_hour?
    if Time.now >= Time.parse('3pm') && Time.now <= Time.parse('4pm')
      return true
    else
      return false
    end
  end




end

class Item
  attr_reader :name
  attr_reader :price

  def initialize(name,price)
    @name = name
    @price = price
  end
end


