require 'time' # you're gonna need it

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end

class Bar
  attr_reader :name
  attr_accessor :menu_items

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
  end

  def add_menu_item(name, price)
    @menu_items << Item.new(name, price)
  end

  def happy_discount=(new_discount)
    if new_discount > 1
      @happy_discount = 1
    elsif new_discount < 0
      @happy_discount = 0
    else
      @happy_discount = new_discount
    end
  end

  def happy_discount
    if happy_hour?
      # refactored code above
      # if @happy_discount > 1
      #   return 1
      # elsif @happy_discount < 0
      #   return 0
      # end
      return @happy_discount
    else
      return 0
    end
  end

  def happy_hour?

  end

end





# Time.stub(:now).and_return(my_stuff)
