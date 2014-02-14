require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount, :drink_record

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @drink_record = []
  end

  def add_menu_item(name, price, exempt = false)
    new_item = Item.new(name, price, exempt = false)
    @menu_items << new_item
  end

  def drink_purchase(name)
    @menu_items.each do |item|
      if name == item.name
        @drink_record << item
      else
        nil
      end
    end
  end

  def most_popular_drink
    @drink_record.group_by do |item|
      item
    end.values.max_by(&:size).first.name
  end

  def happy_discount=(value)
    if value < 0
      @happy_discount = 0
    elsif value > 1
      @happy_discount = 1
    else
      @happy_discount = value
    end
  end

  def happy_hour?
    t = Time.now
    if t.hour >= 15 && t.hour <= 16
      return true
    else
      return false
    end
  end

#Get price of drinks. If happy hour, 50% discount. If Monday
#or Wednesday, 25% discount. If item is exempt, no discount
#during happy hour.
  def get_price(name)
    t = Time.now
    @menu_items.each do |item|
      if name == item.name && item.exempt == false
          if self.happy_hour? == true
            if t.strftime("%A") === 'Monday' || t.strftime("%A") == 'Wednesday'
              return item.price - (item.price * 0.25)
            else
              return item.price * (0.5)
            end
          else
            return item.price
          end
      elsif item.exempt == true
        return item.price
      else
        return nil
      end
    end
  end

end

class Item
  attr_accessor :name, :price, :exempt

  def initialize(name, price, exempt = false)
    @name = name
    @price = price
    @exempt = exempt
  end

end
