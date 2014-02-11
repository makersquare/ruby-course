require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items
  def initialize(name)
    @name=name
    @menu_items=[]
    @happy_discount=0
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
end

class Menu
  attr_accessor :name
  attr_accessor :price
  def initialize(name,price)
    @name=name
    @price=price
  end
end
