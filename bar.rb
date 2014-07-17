require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :curr_time

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @discount = 0
    @happy_hour = false
    @curr_time = Time.now.hour
  end

  def add_menu_item(name, price)
    new_item = MenuItem.new(name, price)
    @menu_items.push(new_item)
  end

  def happy_discount
    if !self.happy_hour?
      @happy_discount = 0
    else
      @happy_discount = @discount
    end
  end

  def happy_hour?
    if @curr_time == 15 
      @happy_hour = true
    else
      @happy_hour = false
    end
  end

  def happy_discount=(percent)
    if (percent < 1 && percent > 0)
      @discount = percent
    elsif percent > 1
      @discount = 1
    else
      @discount = 0
    end
  end
end

class MenuItem
  attr_reader :name, :price, :details
  def initialize(name, price)
    @name = name
    @price = price
  end
end
