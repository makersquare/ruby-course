require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :happy_discount, :happy_hour, :items_purchased
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @items_purchased = []
  end
  def add_menu_item(name, price)
    @menu_items.push(Item.new(name, price))
  end

  def happy_discount=(value)
    if value >= 0 && value <= 1
      @happy_discount = value
    elsif value > 1
      @happy_discount = 1
    else
      @happy_discount = 0
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_hour?
    if Time.now.hour == 15
      true
    else
      false
    end
  end

  def get_price(item)
  if item.specific_discount == nil
    if happy_hour?  && item.happy_item == true
          item.price * (1 - @happy_discount)
    else
        item.price
    end
  else
    if happy_hour?
      item.price * (1 - item.specific_discount)
    else
      item.price
    end
  end
end

  def day_checker
    today = Time.now
    if today.monday? || today.wednesday?
      @happy_discount = 0.5
    else
      @happy_discount = 0.25
    end
  end

  def item_bought(item)
      @items_purchased.push(item.name)
  end

  def most_popular_item
      @items_purchased.inject(Hash.new(0)){ |h,i| h[i] += 1; h }.max{ |a,b| a[1] <=> b[1] }.first
  end
end



class Item
attr_reader :name, :price, :happy_item, :specific_discount
  def initialize(name, price, happy_item=true, specific_discount=nil)
    @name = name
    @price = price
    @happy_item = happy_item
    @specific_discount = specific_discount
  end



  def get_price
    @price
  end

end







