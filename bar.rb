require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount

 def initialize(name)
  @name = name
  @menu_items = []
  @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items  << Menu.new(name, price)
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
    t = Time.now
    if t.hour > 16 || t.hour < 15
      false
    else
      true
    end
  end

  def get_price(name)
    price = 0
    menu_items.each do |x|
      if x.name == name
        price = x.price
      end
    end
    if happy_hour?
      price / 2
    else
      price
    end
  end
end



class Menu
attr_accessor :name, :price

def initialize(name, price)
  @name = name
  @price = price
end

end
