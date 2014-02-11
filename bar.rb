require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items <<  MenuItem.new(name, price)
  end

  def happy_discount=(discount)
    if discount >= 1
      @happy_discount = 1
    elsif discount <= 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    Time.now.between?(Time.parse('3 pm'), Time.parse('3 pm'))
  end

end


class MenuItem
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end

