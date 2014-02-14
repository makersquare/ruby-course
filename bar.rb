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

	def happy_discount
		@happy_discount
		if @happy_discount >1
			@happy_discount=1
		elsif @happy_discount<0
			@happy_discount=0
		else
			@happy_discount
		end	
	end

	def happy_hour?
		t1=Time.now
		t2=Time.parse("3:00pm")
		t3=Time.parse("4:00pm")
		#binding.pry
		if t1.between?(t2, t3)
			true
		else
			false
		end

		# t1=Time.new
		# t2=Time.parse("3:30")
		# if t1 == t2
		# 	true
		# else
		# 	false
		# end
	end
end

class BarItem
	attr_reader :name, :price

	def initialize(name, price)
		@name=name
		@price=price
	end
end

