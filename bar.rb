require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name,cost)
    @menu_items << Food.new(name,cost)
  end

  def happy_discount
    if(happy_hour?)
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(discount)
    if discount.abs <= 1
      @happy_discount = discount
    else
      @happy_discount = discount<0 ? 0:1
    end
  end

  def happy_hour?
    if Time.now.hour == 15
      true
    else
      false
    end
  end
end


class Food

  attr_reader :name, :price

  def initialize(name,cost)
    @name = name
    @price = cost
  end

end
