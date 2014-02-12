require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount

 def initialize(name)
  @name = name
  @menu_items = []
  @happy_discount = 0
  end

  def add_menu_item(name, price, exempt = false)
    @menu_items << Menu.new(name, price, exempt)
    puts "#{@menu_items}"
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

  def get_price(name)
    price = 0
    drink_exempt = false
   if @happy_discount == 0 && (Time.now.wday == 1 || Time.now.wday == 3)
      @happy_discount = 0.5
    else
      @happy_discount = 0.75
    end
    menu_items.each do |x|
      if x.name == name
        price = x.price
        drink_exempt = x.exempt
      end
    end
    if happy_hour?
      if drink_exempt == true
        price
      else
      price * happy_discount
    end
    else
      price

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
end


class Menu
attr_accessor :name, :price, :exempt

def initialize(name, price, exempt = false)
  @name = name
  @price = price
  @exempt = exempt
end

end
