require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items, :purchases, :total_purchases

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @purchases = Hash.new(0)
    @total_purchases = 0
    @discounts = [0.25, 0.5, 0.25, 0.5, 0.25, 0.25, 0.25]
  end

  def add_menu_item(item, price)
    @menu_items << MenuItem.new(item, price)
  end

  def exempt_drink(drink_name)
    select_drink(drink_name).exempt = true
  end

  def purchase(drink_name)
    purchases[drink_name] += 1
    @total_purchases += 1
  end

  def most_popular
    answ = []
    order = @purchases.sort_by { |k,v| v }.reverse

    for i in order
      answ << "#{i[0]}: #{i[1]}"
    end
    answ
  end


  def select_drink(drink_name)
    @menu_items.select { |item| item.name == drink_name }.first
  end

  def happy_hour?
    if Time.now >= Time.parse("3pm") && Time.now <= Time.parse("4pm")
      return true
    else
      return false
    end
  end

  def happy_discount
    if happy_hour?
      @happy_discount
    else
      0
    end
  end

  def happy_discount=(value)
    if value > 1
      @happy_discount = 1
    elsif value < 0
      @happy_discount = 0
    else
      @happy_discount = value
    end
  end

  def discount_for_day(day)
    @discounts[day]
  end


  def get_price(drink_name)
    drink = select_drink(drink_name)

    @happy_discount = discount_for_day(Date.today.wday)


    if self.happy_hour? && drink.exempt == false
      (drink.price * @happy_discount).round(2)
    else
      drink.price
    end
  end

end

class MenuItem

  attr_reader :name, :price
  attr_accessor :exempt

  def initialize(name, price)
    @name = name
    @price = price
    @exempt = false
  end

end
