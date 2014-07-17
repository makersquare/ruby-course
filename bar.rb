require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount
  # attr_accessor :happy_discount
  def initialize(name)
    @name=name
    @menu_items=[]
    @happy_discount=0
  end 
  def happy_hour?
    t=Time.now
    if t.hour == 15
      true
    else false
    end
  end
  def add_menu_item(name, price)
    newf=Food.new(name, price)
    @menu_items.push(newf)
  end
  def happy_discount
    if happy_hour?
      @happy_discount
    else 
       return 0
    end
  end
  def happy_discount=(discount)
    if discount > 1
      @happy_discount =1
    elsif discount <0
      @happy_discount =0
    else @happy_discount=discount
    end
  end
        

end

class Food
  attr_reader :name, :price
  def initialize(name,price)
    @name=name
    @price=price
  end
end

