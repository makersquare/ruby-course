require 'time' # you're gonna need it

class Bar
  attr_reader :name, :menu_items, :purchases

  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @discount = 0
  end

  def add_menu_item(name, price)
    @menu_items.push(MenuItem.new(name, price))
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
  def exempt(item_name)
    @menu_items.find{|drink| drink.name == item_name}.exempt = true

  end
  def get_price(item_name)
    item = @menu_items.find{|drink| drink.name == item_name}
    item.custom_discount ? discount = item.custom_discount : discount = @discount
    if (happy_hour? && (Time.now.monday? || Time.now.wednesday?) && !(item.exempt))
      (item.price - item.price * discount).round(2)
    elsif (happy_hour? && !(item.exempt))
      (item.price - item.price * (discount/2)).round(2)
    else
      item.price
    end
  end

  def purchase
    show_menu
    puts "Which would you like?"
    @choice = gets.chomp.to_i - 1
    items = @menu_items.length
    while !((1..items).to_a.include?(@choice))
      puts "Invalid choice. Try again."
      @choice = gets.chomp.to_i - 1
    end
    puts "\nHere's your %s!\n\n" % @menu_items[@choice].name
    happy_hour? ? @menu_items[@choice].purchases[:happy_hour] += 1 : @menu_items[@choice].purchases[:regular_hours] += 1
    puts "Would you like to make another purchase? Y/N"
    repeat = gets.chomp.upcase
    purchase if repeat == 'Y'
  end

  def show_menu
    count = 1 
    @menu_items.each do |k|
      price = get_price(k.name)
      puts "#{count}. #{k.name} $%.2f" % k.price
      count += 1
    end
  end

def most_popular
  regular = @menu_items.max_by {|k| k.purchases[:regular_hours]}
  happy = @menu_items.max_by {|k| k.purchases[:happy_hour]}
  puts "The most popular drink during regular hours is the " + regular.name.to_s + " which has been purchased " + regular.purchases[:regular_hours].to_s + " times."
  puts "The most popular drink during happy hour is the " + happy.name.to_s + " which has been purchased " + happy.purchases[:happy_hour].to_s + " times."
end

  def custom_discount(item_name,discount)
    @menu_items.find{|drink| drink.name == item_name}.custom_discount = discount
  end

  def get_purchase_data
    happy_purchases = 0
    regular_purchases = 0
    @menu_items.each do |drink|
      happy_purchases += drink.purchases[:happy_hour]
      regular_purchases += drink.purchases[:regular_hours]
    end
    puts "Happy hour purchases: #{happy_purchases}"
    puts "Regular hours purchases: #{regular_purchases}"
  end
end

class MenuItem
  attr_reader :name, :price, :exempt, :purchases
  attr_accessor :custom_discount
  def initialize(name, price)
    @name = name
    @price = price
    @exempt = false
    @purchases = {happy_hour: 0, regular_hours: 0}
    @custom_discount = nil
  end
end

bar = Bar.new("Videology")
bar.add_menu_item('G&T', 6)
bar.add_menu_item('Rum and Coke', 5)
bar.add_menu_item('Blue Moon', 3)
bar.add_menu_item('Whiskey Sour', 7)
bar.add_menu_item('Cosmo', 5.40)
bar.add_menu_item('Salty Dog', 7.80)
bar.custom_discount('Rum and Coke', 0.3)
bar.happy_discount = 0.5
bar.purchase
bar.get_purchase_data
bar.most_popular

