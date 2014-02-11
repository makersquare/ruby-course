require 'time' # you're gonna need it

class Bar

  attr_reader :name
  attr_accessor :menu_items, :happy_discount, :menu_items_hash

  def initialize(name, happy_discount=0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
    @menu_items_hash = {}
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
    @menu_items_hash.store(name,price)
    item = Drink.new(name,price)
    @menu_items.push(item)

  end

  def happy_hour?
    #need to add a method under true that multiples all price values by 0.5
    if (Time.now.hour >= 15 && Time.now.hour <=16)
      return true
    else
      return false
    end
  end

  def get_price(drink)
    #how do i pull the value of a drink from an array?
    # add the 50% break happy hour
    if happy_hour?
      return @menu_items_hash[drink] * 0.5
    else
      return @menu_items_hash[drink]
    end

  end



end


class Drink

  attr_accessor :name, :price

  def initialize(name,price)
    @name = name
    @price = price
  end

end





