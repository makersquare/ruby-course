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
      if t.wednesday? || t.monday?
        @happy_discount=0.5
      else @happy_discount=0.25
      end
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

  # def get_price(food)
  #   temp_price=0.0
  #   @menu_items.each do |fooditem|
  #     if food==fooditem.name
  #       return fooditem.price
  #     end
  #   end
  # end
        

end

class Food
  attr_reader :name, :price
  def initialize(name,price)
    @name=name
    @price=price
  end
end

