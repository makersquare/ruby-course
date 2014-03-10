require 'time' # you're gonna need it

class Bar 
  attr_reader :name
  attr_accessor :menu_items, :happy_discount, :happy_purchase
  def initialize(name)
    @name = "The Irish Yodel"
    @menu_items = []
    @happy_discount = 0
    @purchased_drinks = []
    @happy_purchase = 0
    @happy_purchased_drinks =[]
  end

  def add_menu_item(name,price)
    @menu_items.push(Item.new(name,price))
  end

  def happy_hour?
    current_time = Time.now
    four = Time.parse('4 pm')
    three = Time.parse('3 pm')
    if current_time.between?(three,four)
      true
    else
      false
    end
  end

  def happy_drink?(item)
    item.happy
  end

  def unique?(item)
    item.unique
  end

  def happy_discount (item)
    if  slowday? && unique?(item) && happy_hour? && happy_drink?(item)
      @happy_discount = 0.5
    elsif unique?(item) && happy_hour? && happy_drink?(item)
      @happy_discount = 0.7
    elsif happy_hour? && happy_drink?(item)
      @happy_discount
      else 
      0 
    end
  end

  def slowday?
    monday = Time.now.monday?
    wednesday = Time.now.wednesday?
    if monday && wendesday
      true
      else 
      false
      end
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

  def purchase_drink(item)
    
    if happy_hour?
    @happy_purchase += 1
    @happy_purchased_drinks.push(item)
  end
    @purchased_drinks.push(item)
  
  end

  def most_popular
    drinkname = @purchased_drinks.map{|x| x.name}
    popular = drinkname.inject(Hash.new(0)){|x,y| x[y] +=1; x}.sort_by{|a,b| b}.reverse
    popular.map{|x| x[0]}
  end

  def most_popular_happy
    drinkname = @happy_purchased_drinks.map{|x| x.name}
    popular = drinkname.inject(Hash.new(0)){|x,y| x[y] +=1; x}.sort_by{|a,b| b}.reverse
    popular.map{|x| x[0]}
  end
end

class Item 
  attr_accessor :name, :price, :happy, :unique
  def initialize(name,price,happy = false, unique = false)
    @name = name
    @price = price
    @happy = happy
    @unique = unique
  end
end
