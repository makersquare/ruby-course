require 'time' # you're gonna need it

class Bar
attr_reader :name, :menu_items
attr_writer :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @items_sold = {}
  end

  def add_menu_item(name,price)
    @menu_items.push(Item.new(name,price))
  end

  def happy_hour?
    return true if Time.now.hour == 15
    false
  end

# Implemented Extension 1 (Higher discount on slow days) by doubling the default discount on Monday and Wednesday
  def happy_discount
    if self.happy_hour?
      if Time.now.monday? || Time.now.wednesday?
        if @happy_discount <= 0.5
          return @happy_discount * 2
        else
          return 1
        end
      else
        return @happy_discount
      end
    end
    0
  end

  def happy_discount=(discount)
    if discount > 1
      @happy_discount = 1
    elsif discount < 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def current_cost(item)
    return item.price * (1 - @happy_discount) if happy_hour? && !item.top_shelf
    item.price
  end

  def buy(item)
    if !@items_sold.key?(item.name)
      @items_sold[item.name] = 1
    else
     @items_sold[item.name] += 1
   end
  end

  def times_purchased(item)
    @items_sold[item.name]
  end
end


class Item
  attr_reader :name, :price, :top_shelf

  def initialize(name, price, top_shelf=false)
    @name = name
    @price = price
    @top_shelf = top_shelf
  end
end
