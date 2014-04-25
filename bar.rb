require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  # Take in a name and price and create a new Item instance based on these args. Add new Item to @menu_items
  def add_menu_item(name,price)
    item = Item.new(name,price)
    @menu_items << item
  end


  # Custom happy hour discount setter - always between 0 and 1
  def happy_discount=(discount)
    if discount >= 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      return 0
    end
  end

  def happy_hour?
    now = Time.now
    if now > Time.parse("3pm") && now < Time.parse("4pm")
      true
    else
      false
    end
  end

  def get_price(item_name)
    # Find the item by name in the menu_items array, apply a happy hour discount if necessary and then return the price
    item_price = @menu_items.select{|item| item.name == item_name}.first.price
    if happy_hour?
      item_price = item_price * happy_discount
    else
      item_price
    end
  end
end

class Item
  attr_accessor :name, :price

  def initialize(name,price)
    @name = name
    @price = price
  end

end
