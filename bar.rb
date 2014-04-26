require 'time' # you're gonna need it

class Bar

  attr_reader :name, :menu_items, :purchases, :total_purchases,
              :happy_hour_purchases, :regular_purchases

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @purchases = Hash.new(0)
    @happy_purchases = Hash.new(0)
    @total_purchases = 0
    @happy_hour_purchases = 0
    @regular_purchases = 0
    @discounts = [0.25, 0.5, 0.25, 0.5, 0.25, 0.25, 0.25]
  end

  def add_menu_item(item, price)
    @menu_items << MenuItem.new(item, price)
  end

  def exempt_drink(drink_name)
    select_drink(drink_name).exempt = true
  end

  def purchase(drink_name)
    @purchases[drink_name] += 1
    @total_purchases += 1

    if happy_hour?
      @happy_purchases[drink_name] += 1
      @happy_hour_purchases += 1
    else
      @regular_purchases += 1
    end
  end

  def most_popular(time_frame)
    answ = []

    if time_frame == :total
      order = sort_most_popular(@purchases)
    elsif time_frame == :happy_hour
      order = sort_most_popular(@happy_purchases)
    else
      return nil
    end

    for i in order
      answ << "#{i[0]}: #{i[1]}"
    end
    answ
  end

  def sort_most_popular(hash)
    hash.sort_by { |k,v| v }.reverse
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

  def update_discount(day, price)
    day_hash = {
      sunday: 0,
      monday: 1,
      tuesday: 2,
      wednesday: 3,
      thursday: 4,
      friday: 5,
      saturday: 6
    }

    @discounts[day_hash[day.downcase.to_sym]] = price
  end

  def unique_discount(drink, discount)
    select_drink(drink).unique = discount
  end

  def get_price(drink_name)
    drink = select_drink(drink_name)
    unique = drink.unique
    price = drink.price

    @happy_discount = discount_for_day(Date.today.wday)


    if self.happy_hour? && drink.exempt == false
      unique ? (unique * price).round(2) : (price * @happy_discount).round(2)
    else
      price
    end
  end

end

class MenuItem

  attr_reader :name, :price
  attr_accessor :exempt, :unique

  def initialize(name, price)
    @name = name
    @price = price
    @exempt = false
    @unique = false
  end

end
