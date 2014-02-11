require 'time' # you're gonna need it

class Bar
attr_reader :name
attr_accessor :menu_items, :happy_discount

  def initialize(name, menu_items = nil, happy_discount = 0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
  end

  def add_menu_item(name, price)
    item = Drink.new(name, price)
    @menu_items.push(item)
  end


end



class Drink
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
