require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items, :transactions

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = {monday: 0,
      tuesday: 0,
      wednesday: 0,
      thursday: 0,
      friday: 0,
      saturday: 0,
      sunday: 0}
    @transactions = []
  end

  def add_menu_item(name, price)
    new_item = MenuItem.new(name, price)
    @menu_items << new_item
  end

  def happy_hour?
    if (Time.now.hour >= 15) && (Time.now.hour < 17)  #between 3pm & 5pm
      return true
    else
      return false
    end
  end

  def happy_discount
    if self.happy_hour?
      case Time.now.wday
      when 0
        return @happy_discount[:sunday]
      when 1
        return @happy_discount[:monday]
      when 2
        return @happy_discount[:tuesday]
      when 3
        return @happy_discount[:wednesday]
      when 4
        return @happy_discount[:thursday]
      when 5
        return @happy_discount[:friday]
      when 6
        return @happy_discount[:saturday]
      end
    else
      return 0
    end
  end

  def happy_discount=(discount) # Accepts either a number or an array -- if it's array it requires
                                # [day-of-week-symbol, discount]

    # if it's been passed a number, load the variables
    if !discount.is_a?(Array)
      fixed_discount = discount
      day = nil
    else  # if it's been passed an array, load the variables
      fixed_discount = discount[1]
      day = discount[0]
    end

    # keep it between 0 & 1
    if (fixed_discount > 1)
      fixed_discount = 1
    elsif (fixed_discount < 0)
      fixed_discount = 0
    end

    ## if it's been passed a value for the week, load the hash
    case day
    when nil
      @happy_discount.each { |k,v| @happy_discount[k] = fixed_discount }

      ## Otherwise, put the correct discount on the correct day
    when :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
      @happy_discount[day] = fixed_discount
    else
      puts "Invalid Day"
      return false
    end
  end

  def current_price(item)  #takes an item and returns it's current adjusted price
    if self.happy_hour?
      if (item.special_discount != nil)
        return item.price - (item.price * item.special_discount)
      else
        return item.price - (item.price * self.happy_discount)
      end
    else
      return item.price
    end
  end

  def ring_sale(item)
    new_transaction = ItemSold.new(item, self.happy_hour?, self.current_price(item), Time.now)
    transactions << new_transaction
  end

  def most_popular_drinks  # returns an 2dim array of [name, number-sold] in order of most popular
    # count the occurences of drinks and store them in a hash
    most_popular_drinks = Hash.new 0
    @transactions.each do |x|
      most_popular_drinks[x.item.name] += 1
    end

    # return them in order of most popular to least popular
    return most_popular_drinks.sort_by { |k,v| v }.reverse

  end

  def most_popular_happy_hour_drinks  # returns an 2dim array of [name, number-sold] in order of most popular
    happy_hour_drink_sales = Hash.new(0)
    @transactions.each do |x|
      if x.happy_hour == true
        happy_hour_drink_sales[x.item.name] += 1
      end
    end
    return happy_hour_drink_sales.sort_by { |k,v| v }.reverse
  end

  def most_popular_non_happy_hour_drinks   # returns an 2dim array of [name, number-sold] in order of most popular
    non_happy_hour_drink_sales = Hash.new(0)
    @transactions.each do |x|
      if x.happy_hour == false
        non_happy_hour_drink_sales[x.item.name] += 1
      end
    end
    return non_happy_hour_drink_sales.sort_by { |k,v| v }.reverse
  end

end  #end Class Bar


class MenuItem
  attr_accessor :name, :price
  attr_reader :special_discount

  def initialize(name, price)
    @name = name
    @price = price
    @discount_amount = nil
  end

  def special_discount=(special_discount)
    if special_discount < 0   # if input is less than 0, empty it
      @special_discount = nil
    elsif special_discount > 1  # if input is greater than 1, make it 1
      @special_discount = 1
    else
      @special_discount = special_discount
    end
  end
end

class ItemSold
  attr_accessor :item, :happy_hour, :price, :time_of_transaction

  def initialize(item, happy_hour, price, time_of_transaction)
    @item = item
    @happy_hour = happy_hour
    @price = price
    @time_of_transaction = time_of_transaction
  end


end
