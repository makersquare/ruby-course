require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :exempted_drinks, :purchased_drinks, :hh_drinks_bought

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @exempted_drinks = []
    @purchased_drinks = Hash.new
    @hh_drinks_bought = Hash.new
  end

  def happy_hour?
    if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm")
      return true
    else
      return false
    end
  end

  def add_menu_item(item, cost)
    @menu_items << Item.new(item, cost)
  end

  def make_purchase(item, happy_hour)
    in_hash = false

    if happy_hour && @hh_drinks_bought.length == 0
      @hh_drinks_bought[item] = 1
      return true
    end

    if @purchased_drinks.length == 0
      @purchased_drinks[item] = 1
      return true
    end

    if happy_hour
      @hh_drinks_bought.each do |key, value|
        if key == item
          in_hash = true
        end
      end
      in_hash ? @hh_drinks_bought[item] += 1 : @hh_drinks_bought[item] = 1
    else
      @purchased_drinks.each do |key, value|
        if key == item
          in_hash = true
        end
      end
      in_hash ? @purchased_drinks[item] += 1 : @purchased_drinks[item] = 1
    end

  end

  def most_popular_drink(happy_hour)
    most_popular = ""
    max = 0

    if happy_hour
      @hh_drinks_bought.each do |key, value|
        if value > max
          most_popular = key
          max = value
        end
      end
    else
      @purchased_drinks.each do |key, value|
        if value > max
          most_popular = key
          max = value
        end
      end
    end

    return most_popular
  end

  def exempt_drink(drink)
    exempted_drinks << drink
    @menu_items.each do |menu_object|
      if menu_object.name == drink
        menu_object.exempt = true
      end
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
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

  def get_price(item, is_happy_hour, date)
    price = 0
    exempt = false
    week_day = date.cwday
    @menu_items.each do |menu_object|
      if menu_object.name == item
        price = menu_object.price
        exempt = menu_object.exempt
      end
    end

    if is_happy_hour == false || exempt
      return price
    elsif week_day == 1 || week_day == 3
      @happy_discount = 0.5
      return price * @happy_discount
    else
      @happy_discount = 0.25
      return (price - (price * @happy_discount)).round(2)
    end
  end
end

class Item
  attr_reader :name, :price
  attr_accessor :exempt
  def initialize(name, price)
    @name = name
    @price = price
    @exempt = false
  end
end

