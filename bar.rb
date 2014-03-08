require 'time' # you're gonna need it

class Bar
	attr_reader :name, :menu_items
	attr_writer :happy_discount
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
		@happy_discount || 0
	end
end

class Item
	attr_reader :name, :price
	def initialize(name, price)
		@name = name
		@price = price
	end
end