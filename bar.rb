require 'time' # you're gonna need it
require 'date'

class Bar
  attr_reader :name, :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0.75
  end

  # Take in a name and price and create a new Item instance based on these args. Add new Item to @menu_items
  def add_menu_item(name,price,exempt=false)
    item = Item.new(name,price,exempt)
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
    today = Date.today.wday
    if today == 1 || today == 3
      @happy_discount = 0.5
    else
      @happy_discount = 0.75
    end
    if happy_hour?
      @happy_discount
    else
      0
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

  def buy_drink(item_name)
    # Find the item by name in the menu_items array, apply a happy hour discount if necessary and then return the price
    item = @menu_items.select{|item| item.name == item_name}.first
      item_price = item.price
      if happy_hour? && item.exempt != true
        # Make sure that drink prices aren't 0 if happy_discount isn't set
        if happy_discount != 0
          item_price = item_price * happy_discount
        end
      else
        item_price
      end
  end
end

class Item
  attr_accessor :name, :price, :exempt

  def initialize(name,price,exempt=false)
    @name = name
    @price = price
    @exempt = exempt
  end

end
