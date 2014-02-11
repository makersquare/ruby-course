require 'time' # you're gonna need it
class Bar
	attr_accessor :menu, :happy_discount
	attr_reader :bar, :name

	def initialize (name)
		@name=name
		@menu = []
		@happy_discount=0
	end

	def menu_items
		@menu
	end

	def add_menu_item(item, price)
		@menu << BarItem.new(item, price)

	end

	# def happy_discount
	# 	@happy_discount + 0.5
	# end
end

class BarItem
	attr_reader :name, :price

	def initialize(name, price)
		@name=name
		@price=price
	end
end

