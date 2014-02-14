require 'time' # you're gonna need it

class Bar
  attr_reader :name, :happy_discount, :happy_hour
  attr_accessor :menu_items, :drinks_ordered
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @drinks_ordered = []
  end

  def add_menu_item(name, price, discount: true)
    @menu_items << MenuItem.new(name, price, discount)
  end

  def happy_discount=(discount)
    if discount < 0
      @happy_discount = 0
    elsif discount > 1
      @happy_discount = 1
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    time = Time.now
    if time.hour >= 15 && time.hour <= 16
      if !(time.monday? || time.wednesday?)
        @happy_discount = 0.5
        true
      else
        @happy_discount = 0.25
        true
      end
    else
       false
    end
  end

  def get_price(name)
    @menu_items.each do |item|
      # if name == item.name
      if item.name == name
        if (self.happy_hour? == true) && (item.discount == true)
          return item.price * self.happy_discount
        else
          return item.price
        end
      end
    end
  end

  def purchase_drink(name)
    @menu_items.each do |item|
      if item.name == name
        if (self.happy_hour? == true) && (item.discount == true)
           @drinks_ordered << [name,  item.price * self.happy_discount]
        else
           @drinks_ordered << [name, item.price]
        end
      end
    end
  end

  def calc_top_selling_drinks
    order_log = Hash.new(0)
    puts @drinks_ordered.each { |drink| order_log[drink] += 1 }
  end
end


class MenuItem
  attr_accessor :name, :price, :discount
  def initialize(name, price, discount)
    @name = name
    @price = price
    @discount = discount
  end
end
