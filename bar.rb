require 'time' # you're gonna need it

class Bar
	attr_reader :name, :menu_items, :happy_discount

	def initialize(name)
		@name = name
		@menu_items = Array.new
		@happy_discount = 0
	end

	def add_menu_item(name, price)
		menu_items << MenuItem.new(name, price)
	end

	def happy_discount=(discount)
		if discount >= 0 && discount <= 1
			@happy_discount = discount
		elsif discount < 0
			@happy_discount = 0
		elsif discount > 1
			@happy_discount = 1
		end
	end

	def happy_hour?
		Time.now.hour == 15 ? true : false
	end
end

class MenuItem
	attr_reader :name, :price

	def initialize(name, price)
		@name = name
		@price = price
	end
end
