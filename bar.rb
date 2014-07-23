require 'time' # you're gonna need it

class Bar
  attr_reader :name
  attr_accessor :menu_items
  def initialize(name)
    @name = name
    @menu_items = []
    @happy_discount = 0
    @happy_hour = false
    @popular = Hash.new(0)
  end

  def most_pop
      @popular.key(@popular.values.max)
  end 
  def happy_discount
      if(happy_hour?)
        return @happy_discount
      else
        return 0
      end
  end
  def happy_hour?
      t = Time.now.hour
      if(t == 15)
        @happy_hour = true
      else
        @happy_hour = false
      end
  end
  def happy_discount=(stuff)
      if (stuff > 1)
        @happy_discount = 1
      elsif stuff < 0
        @happy_discount = 0
      else
        @happy_discount = stuff
      end

  def set_discount
      t = Time.now.wday
      if(t == 1 || t == 3)
        @happy_discount = 0.50
      else
        @happy_discount = 0.25
      end
  end
   def get_price(name)
      @menu_items.each  do |variable|
        if(variable.name == name)
          @popular[name] += 1 
          if(variable.dis_able)
            happy_hour? ? dis = 1 - @happy_discount : dis = 1
            return (variable.price*(dis)).round(2)
          else
              return (variable.price).round(2)
          end
        end
      end
       return "Item does not exist." 
   end       
  end

  def add_menu_item(item, price)
     @menu_items << Drink.new(item, price)
  end 

end


class Drink
    attr_accessor :name, :price, :dis_able
    def initialize(name, price, dis_able =true)
        @name = name
        @price = price
        @dis_able = dis_able
    end
end