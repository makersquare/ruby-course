require 'time' # you're gonna need it

class Item

  attr_reader :name, :price
  def initialize (name, price)
    @name = name
    @price = price
  end
end

class Bar

attr_reader :name, :happy_hour
attr_accessor :menu_items, :happy_discount

  def initialize(name = "The Irish Yodel", menu_items = [], happy_discount = 0)
  @menu_items = menu_items
  @name = name
  @happy_discount = happy_discount

  end

  def add_menu_item(item, price)
    @menu_items << Item.new(item, price)
  end

  def happy_hour?
    current_time = Time.now
    three = Time.parse("3 pm")
    four = Time.parse("4 pm")
    if current_time.between?(three,four)
      true
    else
      false
    end
  end

  def happy_discount#custom getter
    if happy_hour?
        if @happy_discount < 0
          return 0
        elsif @happy_discount > 1
          return 1
        else
          @happy_discount
        end
    else
      0
    end

  end

end
