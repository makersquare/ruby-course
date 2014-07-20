class Bar
  attr_reader :name, :menu_items
  attr_accessor :slow_day_happy_discount

  def initialize(name)
    @name=name
    @menu_items = []
    @happy_discount = 0
    @slow_day_happy_discount = 0
    @special_discounts = {}
  end

  def add_menu_item(name, price, hhstatus = false)
    @menu_items << MenuItem.new(name, price, hhstatus)
  end

  def happy_discount=(x)
    x = check_discount_format(x)
    @happy_discount = x
  end

  def check_discount_format(x)
    x = 0 if x < 0
    x = 1 if x > 1
    x
  end

  def happy_discount
    return 0 unless happy_hour?
    slow_day? ? @slow_day_happy_discount : @happy_discount
  end

  def happy_hour?
    current_hour=Time.now.hour
    current_min=Time.now.min
    current_time = Time.at(current_hour*60 + current_min)
    
    hh_begins = Time.at(15*60)
    hh_ends = Time.at(16*60)

    current_time > hh_begins && current_time < hh_ends 
  end

  def get_price(item)
    return item.price unless item.hhstatus
    (item.price * (1 - happy_discount)).round(2)
  end

  def slow_day?
    return true if Time.now.monday?
    return true if Time.now.wednesday?
    false
  end

  def purchase(item)
     item.purchases << Purchase.new(item, self)
  end

  def analyze_drink_popularity
    @menu_items.sort_by { |x| x.purchases.count }.reverse
  end

  def set_special_discount(item, discount)
    x = check_discount_format(discount)
    @special_discounts[item] = x
  end



end

class MenuItem
  attr_reader :name, :price, :hhstatus, :purchases
  
  def initialize(name, price, hhstatus = false)
    @name = name
    @price = price
    @hhstatus = hhstatus
    @purchases = []
  end
end

class Purchase
  attr_reader :item, :price, :time
  
  def initialize(item, bar)
    @item = item
    @price = bar.get_price(item)
    @time = Time.now
  end
end