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

  def exempt_drink(drink_name)
    select_drink(drink_name).exempt = true
  end

  def purchase(drink_name)
  end

  def select_drink(drink_name)
    @menu_items.select { |item| item.name == drink_name }.first
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

  def get_price(drink_name)
    drink = select_drink(drink_name)

    if (Date.today.monday? || Date.today.wednesday?)
      @happy_discount = 0.5
    else
      @happy_discount = 0.25
    end


    if self.happy_hour? && drink.exempt == false
      (drink.price * @happy_discount).round(2)
    else
      drink.price
    end
  end

end

class MenuItem

  attr_reader :name, :price
  attr_accessor :exempt

  def initialize(name, price)
    @name = name
    @price = price
    @exempt = false
  end

end
