require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items
  attr_accessor :happy_discount
  def initialize(args = {})
    @name = args[:name]
    @menu_items = []
    @happy_discount = 0
  end

  def show_menu
    happy_hour? ? apply_happy_discount : @menu_items
  end

  def get_price(drink_name)
    show_menu.select {|item| item.name == drink_name}.pop.price
  end

  def add_menu_item(name, price)
    menu_items << Item.new(name: name, price: price)
  end

  def hedge_discount
    @happy_discount = 1 if @happy_discount > 1
    @happy_discount = 0 if @happy_discount < 0
  end

  def happy_discount
    hedge_discount
    daily_discount
    happy_hour? ? @happy_discount : 0
  end

  def daily_discount
    today = DateTime.now
    today.monday? || today.wednesday? ? (@happy_discount = 0.5) : (@happy_discount = 0.25)
  end

  def apply_happy_discount
    menu_items.map do |item|
      Item.new(name: item.name, price: item.price - (item.price * happy_discount.to_f))
    end
  end

  def happy_hour?
    Time.now >= Time.parse('3:30 pm') && Time.now <= Time.parse('4:00 pm')
  end
end

class Item
  attr_reader :name
  attr_accessor :price
  def initialize(args = {})
    @name = args[:name]
    @price = args[:price]
  end
end
