require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name,price)
    @menu_items << (Item.new(name,price))
  end

  def happy_hour?
    if Time.now >= Time.parse("3 pm") && Time.now <= Time.parse("4 pm")
      true
    else
      false
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(amount)
    # @happy_discount = amount
    if amount > 1
      @happy_discount = 1
    elsif amount < 0
      @happy_discount = 0
    else
      @happy_discount = amount
    end
  end

  def get_price(name)
    if happy_hour? == false
      @menu_items.each do |item|
        if item.name == name
          return item.price
        end
      end
    end
    if happy_hour? == true
      @menu_items.each do |item|
        if item.name == name
          new_price = item.price - (item.price * @happy_discount)
          return new_price
        end
      end
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
