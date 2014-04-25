require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item, price)
    @menu_items << Item.new(item, price)
  end

  def happy_hour?
    if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm")
      return true
    else
      return false
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
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


end

class Item

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
