require 'time' # you're gonna need it

class Bar
	attr_reader :name, :happy_hour
	attr_accessor :menu_items, :happy_discount, :happy_hour
	def initialize (name, happy_discount=0)
		@name = name
		@menu_items = []
		@happy_discount = happy_discount


	end

	def add_menu_item(item, price)
		@menu_items.push(Item.new(item,price))
	end 

  def happy_hour?
    current_time = Time.now
    three = Time.parse('3 pm')
    four = Time.parse('4 pm')
    if current_time.between?(three,four)
       true
    end
  end



	def happy_discount
    if happy_hour?
      @happy_discount 
    else
      0
    end
   
    end

    def happy_discount=(discount)
      if discount > 1 
        @happy_discount = 1
      elsif discount < 0
        @happy_discount = 0
      else 
        @happy_discount = discount
      end
    end
end




class Item
	attr_accessor :name, :price
	def initialize(name, price)
		@name = name
		@price = price
	end
end

