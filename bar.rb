require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    item = Menu_item.new(name, price)
    @menu_items << item
  end

  def happy_hour?
    if Time.now >= Time.parse('3 pm') && Time.now <= Time.parse('4 pm')
      true
    else
      false
    end
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

  def get_price(name)
    if happy_hour?
      @happy_discount = 0.5
      @menu_items.find do |item| 
        item.name == name
        return item.price = item.price * @happy_discount
      end
    else
      @menu_items.find do |item| 
        item.name == name
        return item.price
      end
    end
  end
end

class Menu_item
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end