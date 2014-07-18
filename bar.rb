require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :purchases

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @discount = 0
    @exempt = []
    @purchases = {}
    @custom_discounts = {}
  end

  def add_menu_item(name, price)
    new_item = MenuItem.new(name, price)
    @menu_items.push(new_item)
  end

  def happy_discount
    if !self.happy_hour?
      @happy_discount = 0
    else
      @happy_discount = @discount
    end
  end

  def happy_hour?
    if Time.now.hour == 15 
      @happy_hour = true
    else
      @happy_hour = false
    end
  end

  def happy_discount=(percent)
    if (percent < 1 && percent > 0)
      @discount = percent
    elsif percent > 1
      @discount = 1
    else
      @discount = 0
    end
  end
  def exempt(drink)
    @exempt << drink
  end
  def get_price(item_name)
    item = @menu_items.find {|item| item.name == item_name}
    discount = @discount
    if @custom_discounts.keys.include? item_name
      discount = @custom_discounts[item_name]
    end
    if (happy_hour? && (Time.now.monday? || Time.now.wednesday?) && !(@exempt.include? item))
      (item.price - item.price * discount).round(2)
    elsif (happy_hour? && !(@exempt.include? item))
      (item.price - item.price * (discount/2)).round(2)
    else
      item.price
    end
  end

  def purchase
    show_menu
    puts "Which would you like? (use number)"
    @choice = gets.chomp
    items = @menu_items.count
    while !((1..items).to_a.include?(@choice.to_i))
      puts "Invalid choice. Try again."
      @choice = gets.chomp
    end
    item = @menu_items[(@choice.to_i - 1)].name
    puts "\nHere's your #{item}!\n\n"
    if @purchases.keys.include? item
      @purchases["#{item}"] += 1
    else
      @purchases["#{item}"] = 1
    end
    puts "Would you like to make another purchase? Y/N"
    repeat = gets.chomp.upcase
    purchase if repeat == 'Y'
  end

  def show_menu
    @count = 1 
    @menu_items.each do |x|
      price = get_price(x.name)

      puts "#{@count}. #{x.name} $%.2f" % x.price
      @count += 1
    end
  end

  def most_popular
    puts "The most popular drink is the #{@purchases.key(@purchases.values.max)} which has been purchased #{@purchases.values.max} times."
  end

  def custom_discount(item_name,discount)
    @custom_discounts[item_name] = discount
  end
end

class MenuItem
  attr_reader :name, :price, :details
  def initialize(name, price)
    @name = name
    @price = price
  end
end



