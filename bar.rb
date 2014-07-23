require 'time' # you're gonna need it


class Item
  attr_reader :name, :cost 
    def initialize(name, cost)
      @name = name
      @cost = cost
      {name => cost}
    end
    def price
      @cost
    end 
end

class Bar
  attr_reader :name 
  attr_accessor :menu
  # attr_writer :happy_discount

  def initialize(name, happy_discount= 0)
    @name = name 
    @menu = []
    @happy_discount = happy_discount 
  end

  def add_menu_item(name, cost)
    menu_item = Item.new(name, cost)
    @menu << menu_item
  end

  def menu_items
    @menu
  end 

  # the following method is the @happy_discount getter
  # method. it replaces `attr_reader :happy_discount`
  def happy_discount
    if happy_hour?
       @happy_discount
    else 
       0 
    end 
  end

  def happy_hour?

  end

  def happy_discount=(discount)
    # if happy_hour? 
        if discount >= 0 && discount <= 1
          puts "hello"
            @happy_discount = discount
        elsif discount > 1
          @happy_discount = 1
        else 
          @happy_discount = 0
        end 
    # else 
    #     "hello"
    # end 
  end 
end 



p  @bar = Bar.new("The Irish Yodel")
p @bar.add_menu_item("milk", 5)
p @bar.add_menu_item("tea", 6)

p (@bar.menu_items.first).name

p @bar.happy_discount
