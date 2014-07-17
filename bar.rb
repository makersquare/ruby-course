require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    # because the add_menu item method has two arguments, 
    # I think a hash is best to keep track of them: @bar.add_menu_item('Cosmo', 5.40)
    # but then I initialized them as objects, so now it's an array of objects with attributes name and price.
    @menu_items = []
  end

  def add_menu_item(item, price)
    # going back and initializing an item as an object.
    new_item = MenuItem.new(item, price)
    @menu_items << new_item
  end
end

#Since we can retreive menu items and call methods on them, they have attributes. Thus, a Class is born!
class MenuItem
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end
