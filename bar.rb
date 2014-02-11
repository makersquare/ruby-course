require 'time' # you're gonna need it
class Bar
	attr_reader :bar, :name

	def initialize (bar, name="The Irish Yodel")
		@bar=bar
		@name=name
	end


end
