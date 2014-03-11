require 'time' # you're gonna need it

class Bar
	
	attr_reader :name, :menu_items
	attr_writer :happy_discount, :happy_hour

	def initialize(name)
		@name = name
		@menu_items = []
	end

	def add_menu_item(item, price)
		@item = item
		@price = price
		@menu_items << Item.new(item, price)
	end

	def happy_discount
		if happy_hour? && @happy_discount
			if @happy_discount > 1
				@happy_discount = 1
			elsif @happy_discount < 0
				@happy_discount = 0
			else
				@happy_discount || 0
			end
		else
			return 0
		end
	end

	def happy_hour?
		if Time.now.hour >=15 && Time.now.hour < 16
			return true
		else
			return false
		end
	end
end

class Item
	attr_reader :name, :price
	def initialize(name, price)
		@name = name
		@price = price
	end
end