require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name, happy_discount=0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
  end

  def happy_discount
    if happy_hour? == true
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(happy_discount)
    if happy_discount < 0
      @happy_discount = 0
    elsif happy_discount > 1
      @happy_discount = 1
    else
      @happy_discount = happy_discount
    end
  end

  def happy_hour?
    Time.now.hour == 15
  end

  def add_menu_item(name, price)
    @menu_items << MenuItem.new(name, price)
  end

end

class MenuItem
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
