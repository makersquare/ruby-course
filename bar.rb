require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :item, :cost, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
  end

  def add_menu_item(item, cost)
    new_item = MenuItems.new(item, cost)
    @menu_items << new_item
  end

  def get_price(drinks)
    drinks = @menu_items.select {|item| item.name == drinks.name}
    price = drinks[0].price
    if happy_hour?
      @happy_discount = 0.5
      price * (1 - @happy_discount)
    else
      price
    end
  end

  def happy_hour?
    if Time.now >= Time.parse('3:00 pm') && Time.now <= Time.parse('4:00 pm')
      true
    else
      false
    end
  end

  def happy_discount=(x)
    if x < 1 && x > 0
      @happy_discount = x
    elsif x < 0
      @happy_discount = 0
    else
      @happy_discount = 1
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      return 0
    end
  end

end

class MenuItems
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end


end
