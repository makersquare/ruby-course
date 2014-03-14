require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = happy_discount
  end

  def add_menu_item(item_name, price)
    item = Item.new(item_name, price)
    @menu_items << item
  end


    def happy_discount=(discount)
    if  discount <= 1 && discount >= 0
      @happy_discount = discount
    elsif discount > 1
      @happy_discount = 1
    else
      @happy_discount = 0
    end
  end

  def happy_discount
    if happy_hour? == true
      @happy_discount
    else
      0
    end
  end

  def happy_hour?
      cur_time = Time.now.hour
      if cur_time >= 15 && cur_time <= 15.59
        true
      else
        false
      end
  end


end

class Item
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end
end

