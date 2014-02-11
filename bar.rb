require 'time' # you're gonna need it

class Bar
	attr_reader :name, :happy_discount
	attr_accessor :menu_items
	
	def initialize(name)
		@name = name
		@menu_items = []
		@happy_discount = 0
	end

	def add_menu_item(item, price)
		@menu_items << MenuItem.new(item, price)
	end

	def happy_discount=(value)
		if value > 1
			@happy_discount = 1
		elsif value < 0
			@happy_discount = 0
		else 
			@happy_discount = value
		end
	end

	def happy_hour?
		if (Time.now >= Time.parse("3 PM")) && (Time.now <= Time.parse("4 PM"))
			@happy_discount = 0.5
			true
		else
			false
		end
	end
end

class MenuItem
	attr_accessor :name
	attr_accessor :price

	def initialize(name, price)
		@name = name
		@price = price
	end

end





