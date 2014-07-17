require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items
  attr_accessor :happy_discount

  def initialize(name, happy_discount=0)
    @name = name
    # because the add_menu item method has two arguments, 
    # I think a hash is best to keep track of them: @bar.add_menu_item('Cosmo', 5.40)
    # but then I initialized them as objects, so now it's an array of objects with attributes name and price.
    @menu_items = []
    @happy_discount = happy_discount
  end

  def add_menu_item(item, price)
    # going back and initializing an item as an object.
    new_item = MenuItem.new(item, price)
    @menu_items << new_item
  end

  def happy_hour?
    # the following two lines is my janky code before majorly improved.
    # @happy_hour = Time.now
    # return true if Time.parse('3 pm') <= @happy_hour && @happy_hour <= Time.parse('4 pm')
    Time.now.hour == 15
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

