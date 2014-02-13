require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items
  def initialize(name)
    @name=name
    @menu_items=[]
    @happy_discount=0
    @order=[]
  end

  def add_menu_item(name,price)
    @menu_items.push(Menu.new(name,price))
  end

  attr_reader :happy_discount
  def happy_discount=(discount)
    if discount > 1
      @happy_discount=1
    elsif discount < 0
      @happy_discount=0
    else
      @happy_discount=discount
    end
  end

  def happy_hour?
    t = Time.now.hour

    if t==15
      true
    else
      false
    end
  end

  def add_order(name,amount)
    @menu_items.each do |drink|
      if drink.name == name
        if happy_hour?
          @order << [drink,amount,@happy_discount]
        else
          @order << [drink,amount,0]
        end
      end
    end
  end

  def check_out
    total=0
    @order.each do |x| #x is check out item
      total += x[1]*x[0].price*(1-x[2])
    end
    return total
  end

end

class Menu
  attr_accessor :name
  attr_accessor :price
  def initialize(name,price)
    @name=name
    @price=price
  end
end
