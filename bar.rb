require 'time'

class Bar
  attr_accessor :menu, :name

  def initialize(name, menu)
    @name = name
    @menu = menu
  end

  def get_price(item)
    @regular_price = @menu[item]

    if happy_hour?
      @regular_price -= @regular_price*0.10
    else
      @regular_price
    end

  end

  private

  def happy_hour?

    if Time.now < Time.parse("2 pm") || Time.now > Time.parse("3 pm")
      false
    else
      true
    end

  end

end

class Customer
  def initialize
  end
end
