require 'time' # you're gonna need it

class Bar
	attr_reader :name
	attr_accessor :menu_items, :happy_discount, :item_id

	def initialize(name)
		@name = name
		@menu_items = []
		@happy_discount = 0
		@item_id = 100
	end

	def add_menu_item(name, price)
		@menu_items << Item.new(name, price, @item_id)
		@item_id += 1
	end

	def happy_discount
		if happy_hour?
			@happy_discount
		else
			0
		end
	end

	def happy_discount=(value)
		if value >= 1
			@happy_discount = 1
		elsif value < 1 && value > 0
			@happy_discount = value
		else
			@happy_discount = 0
		end
	end

	def happy_hour?
		time = Time.now
		if time.hour == 15
			true
		else
			false
		end
	end

	def get_price(item_id)
		item_price = nil
		@happy_discount = 0.5
		@menu_items.select do |item|
			if item.id == item_id && happy_hour?
				item_price = item.price * @happy_discount
			elsif item.id == item_id && !happy_hour?
				item_price = item.price
			else
				nil
			end
		end
		item_price
	end
end

class Item
	attr_accessor :name, :price, :id

	def initialize(name, price, id=nil)
		@name = name
		@price = price
		@id = id
	end
end

bar = Bar.new "The Irish Yodel"
bar.add_menu_item('Little Johnny', 9.95)
bar.add_menu_item('Little Johnny 2', 10.00)
puts bar.menu_items
item = bar.menu_items.first
item_id = bar.menu_items.first.id
puts item.name
puts item.price
puts bar.menu_items.first.price
puts bar.get_price(item_id)