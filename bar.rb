require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def happy_hour?
    if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm")
      return true
    else
      return false
    end
  end

  def add_menu_item(item, cost)
    @menu_items << Item.new(item, cost)
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(discount)
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def get_price(item, is_happy_hour)
    price = 0
    @menu_items.each do |menu_object|
      if menu_object.name == item
        price = menu_object.price
      end
    end

    if is_happy_hour
      return price * @happy_discount
    else
      return price
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

