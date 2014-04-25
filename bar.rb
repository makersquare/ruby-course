require 'time' # you're gonna need it

class Bar
	attr_reader :name, :menu_items

	def initialize(name = "The Irish Yodel")
		@name = name
		@menu_items = []
		@happy_discount = 0
	end

	def add_menu_item(name, price)
		@menu_items << MenuItem.new(name, price)
	end

	def happy_discount
		happy_hour? ? @happy_discount : 0
	end

	def happy_discount=(discount)
		if discount <0
			@happy_discount = 0
		elsif discount >1
			@happy_discount = 1
		else
			@happy_discount =discount
		end
	end

	def happy_hour?
		if Time.now > Time.parse("3pm") && Time.now < Time.parse("4pm")
			@happy_hour = true
		else
			@happy_hour = false
		end			
	end
end

class MenuItem
	attr_reader:name, :price
	def initialize(name, price)
		@name = name
		@price= price
	end
end