require 'time'

class Bar

  attr_reader :name, :menu_items
  attr_accessor :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    item = Item.new(name, price)
    @menu_items << item
  end

  def happy_discount
    happy_hour? ? @happy_discount: 0
  end

  def happy_discount=(new_discount)
    if new_discount > 1
      @happy_discount = 1
    elsif new_discount < 0
      @happy_discount = 0
    else
      @happy_discount = new_discount
    end
  end

  def happy_hour?
    return (Time.now >= Time.parse('3pm') &&
      Time.now <= Time.parse('4pm'))
  end

  def get_price(drink)
    drinks = @menu_items.select {|item| item.name.downcase == drink.downcase}
    price = drinks[0].price
    if happy_hour?
      @happy_discount = 0.5
      price * (1 - @happy_discount)
    else
      price
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

