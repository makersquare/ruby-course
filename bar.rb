require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :happy_discount, :sales

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @slow_days = ["Monday", "Wednesday"]
    @sales = {}
  end

  def add_menu_item(name, price)
    @menu_items <<  MenuItem.new(name, price)
  end

  def happy_discount=(discount)
    if discount >= 1
      @happy_discount = 1
    elsif discount <= 0
      @happy_discount = 0
    else
      @happy_discount = discount
    end
  end

  def happy_hour?
    Time.now.between?(Time.parse('3 pm'), Time.parse('4 pm'))
  end

  def get_price(drink)
    item = @menu_items.select { |item| item.name == drink }.first
    price = item.price
    discount = (@happy_discount / 2)

    @slow_days.each do |day|
      if Date.today.send(day.downcase + "?")
        discount = @happy_discount
      end
    end

    self.happy_hour? && item.discount ? (price -= (price * discount)).round(2) : price
  end

  def record_sale(drink)
    unless @sales[drink] then @sales[drink] = [] end
    @sales[drink] << get_price(drink)
  end

  def popular_drinks
    if @sales == {}
      return "No sales recorded."
    else
      @sales.each_pair do |drink, sales_arr|
        total = sales_arr.inject { |sum, sale| sum + sale }
        average = (total/ sales_arr.count)
        return "Drink: #{drink} - Total Sales: $#{sprintf('%.2f', total)} / Average Price: $#{sprintf('%.2f', average)}"
      end
    end
  end

end


class MenuItem
  attr_accessor :name, :price, :discount

  def initialize(name, price)
    @name = name
    @price = price
    @discount = true
  end

end
 @bar = Bar.new "The Irish Yodel"
@bar.add_menu_item('Little Johnny', 9.95)
    @bar.add_menu_item('Cosmo', 5.40)
    @bar.add_menu_item('Salty Dog', 7.80)
    @bar.record_sale('Little Johnny')
    @bar.record_sale('Little Johnny')
    @bar.record_sale('Little Johnny')
    @bar.record_sale('Salty Dog')
    @bar.record_sale('Salty Dog')
    @bar.record_sale('Cosmo')
    @bar.popular_drinks

