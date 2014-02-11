require 'time' # you're gonna need it

class Bar

  attr_reader :name
  attr_accessor :menu_items, :happy_discount

  def initialize(name, happy_discount=0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
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

  def add_menu_item(name,price)
    item = Drink.new(name,price)
    @menu_items.push(item)
  end

  def happy_hour?
    if (Time.now.hour >= 15 && Time.now.hour <=16)
      return true
    else
      return false
    end
  end

  def get_price(drink)

  end



end


class Drink

  attr_accessor :name, :price

  def initialize(name,price)
    @name = name
    @price = price
  end

end





