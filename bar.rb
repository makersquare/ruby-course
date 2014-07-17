require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name="The Irish Yodel")
    @name = name
    @menu_items = []
  end

  def add_menu_item(item, price)
    newfood = Food.new(item, price)
    @menu_items.push(newfood)
  end
end

class Food

  attr_reader :item, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end