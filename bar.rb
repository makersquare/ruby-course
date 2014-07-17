require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount =0 
  end

  def add_menu_item(name, price)
    newfood = Food.new(name, price)
    @menu_items.push(newfood)
  end

  def happy_discount= (discount)
    
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_hour?
    start = Time.now
    if start.hour == 15
      # @happy_discount=0.5
      true
    else
      false
    end
    
  end
end

class Food

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end