require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items, :exempt_drinks
  attr_writer :happy_discount
  attr_accessor :pop_drinks, :pop_drinksHH

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @exempt_drinks = [] #array of discount-exempt drinks
    @pop_drinks = Hash.new(0)
    @pop_drinksHH = Hash.new(0)
  end

  def add_menu_item(item, price)
    new_item = Item.new(item, price)
    @menu_items << new_item
  end

  def happy_hour?
    if Time.now.hour == 15
      true
    else
      false
    end

  end

  def happy_discount
    return @happy_discount if self.happy_hour?
    0
  end

  def happy_discount=(discount)
      weekday = Time.new.wday

      if weekday == 1 || weekday == 3
        @happy_discount = 0.5
      else
        @happy_discount = 0.25
      end

      # -- Commented out below for extension exercise. --
      # -- Discounts now applied according to day only --
      # -- "only returns discount when it's happy hour"
      #    example set to pending in bar_spec.rb --
      #
      # if discount < 0
      #   @happy_discount = 0
      # elsif discount > 1
      #   @happy_discount = 1
      # else
      #   @happy_discount = discount
      # end
  end

  def add_exempt(item)
    @exempt_drinks << item
  end

  def exempt?(item)
    @exempt_drinks.each do |drink|
      if item.name == drink.name
        return true
      end
    end

    return false
  end

  def drink_graph(item)
    if self.happy_hour?
      @pop_drinksHH[item.name]+=1
      return @pop_drinksHH
      else
      @pop_drinks[item.name]+=1
      return @pop_drinks #why the need to explicitly return hash?
    end

  end

end

class Item
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end
