require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :purchase_record
  attr_accessor :happy_discount

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @purchase_record = {}
  end

  def add_menu_item(dish, price)
    new_item = Item.new(dish,price)
    @menu_items << new_item
  end

  def happy_discount=(value)
    if value > 1
      @happy_discount = 1
    elsif value < 0
      @happy_discount = 0
    else
      @happy_discount = value
    end
  end

  def set_discount
      if (Time.now.monday? || Time.now.wednesday? ) && happy_hour?
        return @happy_discount = 0.5
      elsif happy_hour?
        return @happy_discount = 0.25
      else
        @happy_discount = 0
      end
  end

  def happy_hour?
    if Time.now >= Time.parse('3pm') && Time.now <= Time.parse('4pm')
      return true
    else
      return false
    end
  end

  def get_price(drink_name)
    @menu_items.each do |item|
      if item.name == drink_name
        if item.status == 'exempt'
          new_price = item.price
          return new_price
        end
        if happy_hour?
            new_price = (item.price * happy_discount)
            return new_price
        else
          return item.price
        end
      end
    end
  end


  def exempt(drink_name)
    @menu_items.each do |item|
      if item.name == drink_name
        item.status = 'exempt'
      end
    end
  end

  def purchase(drink_name)
    @menu_items.each do |item|
      if item.name == drink_name
        item.counter += 1
        @purchase_record[item.name] = item.counter
      end
    end
  end



end

class Item
  attr_reader :name
  attr_accessor :price, :status, :counter

  def initialize(name,price)
    @name = name
    @price = price
    @status = 'available'
    @counter = 0
  end

end


