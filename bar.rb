require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items.push(Drink.new(name, price.to_f))
  end

  def happy_discount
    if happy_hour? == false
      return 0
    else
      @happy_discount
    end
  end

  def happy_discount=(discount)
    if discount >= 1 
      @happy_discount = 1
    elsif discount <= 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    t = Time.now
    if t.hour == 15
      return true
    else
      return false
    end
  end

  def get_price(drink)
    drink_price = 0.0
    @menu_items.each do |d|
      if d.name == drink
        drink_price = d.price
      end
    end
    if happy_hour?
      return (drink_price * @happy_discount).round(2)
    else
      return drink_price
    end
  end

end

class Drink
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
