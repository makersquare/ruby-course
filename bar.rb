require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(item, price)
    @menu_items << MenuItem.new(item, price)
  end

  def happy_hour?
    if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm") && (Date.today.monday? || Date.today.wednesday?)
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

  def get_price(drink_name)
    drink = @menu_items.select { |item| item.name == drink_name }.first
    @happy_discount = 0.5

    if self.happy_hour?
      drink.price * @happy_discount
    else
      drink.price
    end
  end

end

class MenuItem

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
