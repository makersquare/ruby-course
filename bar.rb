require 'time' # you're gonna need it
require 'date'

class Bar
  attr_reader :name, :menu_items, :purchase_list

  def initialize(name)
    @name = name
    @menu_items = []
    @std_happy_discount = 0.75
    @purchase_list = []
  end

  # Take in a name and price and create a new Item instance based on these args. Add new Item to @menu_items
  def add_menu_item(name,price,exempt=false,spc_discount=nil)
    item = Item.new(name,price,exempt,spc_discount)
    @menu_items << item
  end


  # Custom happy hour discount setter - always between 0 and 1
  def std_happy_discount=(discount)
    if discount >= 1
      @std_happy_discount = 1
    elsif discount < 0
      @std_happy_discount = 0
    else
      @std_happy_discount = discount
    end
  end

  def std_happy_discount
    today = Date.today.wday
    if today == 1 || today == 3
      @std_happy_discount = 0.5
    else
      @std_happy_discount = 0.75
    end
    if happy_hour?
      @std_happy_discount
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
    # Add item to purchase list array, do this before we return the price
    @purchase_list << item

    # Check if it is happy hour and ensure the item is not exempt from happy hour pricing. If either test fails, return the regualard item.price
    # If both tests pass, check if the item has a special discount, if it doesn't, apply standard happy hour pricing, otherwise, use the special discount and return the item_price
    if happy_hour? && item.exempt != true
      # Check
      if item.spc_happy_discount.nil?
        item_price = item_price * std_happy_discount
      else
        item_price = item_price * item.spc_happy_discount
      end
    else
      item_price
    end

  end

  def most_popular_drink
    # Turn the purchsae list array into a hash with unique elements as keys with the number of times each element appears as the value. Then sort the existing hash by the item that occurs most often. Return the name of the first element in the resulting array.
    mp = @purchase_list.group_by{|item| item.name}.values.max_by(&:size)
    mp.first.name
  end
end

class Item
  attr_accessor :name, :price, :exempt, :spc_happy_discount

  def initialize(name,price,exempt=false,spc_discount=nil)
    @name = name
    @price = price
    @exempt = exempt
    @spc_happy_discount = spc_discount
  end

end
