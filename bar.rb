require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items


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
      if item.special_discount
        return item.price - (item.price * item.special_discount)
      else
        return item.price - (item.price * self.happy_discount)
      end
    else
      return item.price
    end
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
    if special_discount < 0   # if input is less than 0, invalidate it
      @special_discount = nil
    elsif special_discount > 1
      @special_discount = 1
    else
      @special_discount = special_discount
    end
  end


end


