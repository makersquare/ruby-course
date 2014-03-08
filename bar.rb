require 'time' # you're gonna need it

class Bar
attr_reader :name, :menu_items, :happy_hour_count, :items_sold, :gross_profit
attr_writer :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @items_sold = {}
    @items_sold_happy = {}
    @items_sold_regular = {}
    @happy_hour_count = 0
    @gross_profit = 0
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
    if happy_hour?
      if item.special_discount
        return item.price * (1 - item.special_discount)
      elsif !item.top_shelf
        return item.price * (1 - @happy_discount)
      else
        return item.price
      end
    end
    item.price
  end

  def buy_general(item, hash)
    if !hash.key?(item)
      hash[item] = 1
    else
      hash[item] += 1
   end
  end

  def buy(item)
    @gross_profit += self.current_cost(item)

    self.buy_general(item, @items_sold)
    if happy_hour?
      self.buy_general(item, @items_sold_happy)
      @happy_hour_count += 1
    else
      self.buy_general(item, @items_sold_regular)
    end
  end

  def times_purchased(item)
    @items_sold[item]
  end

  def most_popular(items_sold=@items_sold)
    items_sold.max_by { |item, times_sold| times_sold }[0]
  end

  def most_popular_happy
    self.most_popular(@items_sold_happy)
  end

  def most_popular_regular
    self.most_popular(@items_sold_regular)
  end
end


class Item
  attr_reader :name, :price, :top_shelf
  attr_accessor :special_discount

  def initialize(name, price, top_shelf=false)
    @name = name
    @price = price
    @top_shelf = top_shelf
    @special_discount = nil
  end
end
