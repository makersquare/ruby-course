require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name="The Irish Yodel")
    @name = name
    @menu_items = []
  end

  def add_menu_item(name, price)
    newfood = Food.new(name, price)
    @menu_items.push(newfood)
  end

  # def get_menu_item(item)
  #   @menu_items.find { |x| x.menu_items }
  # end
end

class Food

  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end