require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_reader :menu_items
  attr_reader :happy_discount

  def initialize(name)
    @menu_items = []
    @name = name
    @happy_discount = 0
    @order = []
  end

  def happy_hour?
    if Time.now.hour == 15
      return true
    else
      return false
    end
  end

  def add_menu_item(name, price)
    @menu_items << Menu_Item.new(name,price)
  end

  def happy_discount=(discount)
    if discount >=1
      @happy_discount = 1
    elsif discount <= 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def add_to_order(name,number)
    @menu_items.each do |drink|
      if drink.name == name
        if happy_hour?
          @order << [drink, number, @happy_discount]
        else
          @order << [drink, number, 0]
        end
      end
    end
  end

  def check_out
    total = 0
    @order.each do |line_item|
      total += line_item[1]*line_item[0].price*(1-line_item[2])
    end
    return total
  end

end

class Menu_Item
  attr_reader :name
  attr_reader :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
