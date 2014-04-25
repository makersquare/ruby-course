require 'time' # you're gonna need it

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items << Item.new(name, price)
  end

  # def happy_discount
  #   @discount = 0
  # end
end





# Time.stub(:now).and_return(my_stuff)
