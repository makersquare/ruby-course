require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name,price)
    @menu_items << (Item.new(name,price))
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

  def happy_discount=(amount)
    # @happy_discount = amount
    if amount > 1
      @happy_discount = 1
    elsif amount < 0
      @happy_discount = 0
    else
      @happy_discount = amount
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
