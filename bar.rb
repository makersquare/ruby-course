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
		weekday = Time.now.wday
		if happy_hour?
			if weekday == 1 || weekday == 3
				# full discount on Mon/wed
				@happy_discount
			else
				#halp discount rest of days
				@happy_discount/2
			end
		else
			0
		end

		# happy_hour? ? @happy_discount : 0
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
			true
		else
			false
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