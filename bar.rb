require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items, :happy_discount

  def initialize(name="The Irish Yodel", happy_discount=0)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount

  end

  def add_menu_item(name, price)
    newfood = Food.new(name, price)
    @menu_items.push(newfood)
  end

  
end

class Food

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end