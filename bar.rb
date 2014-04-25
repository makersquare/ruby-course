require 'time' # you're gonna need it

class Bar
  attr_reader :name

  def initialize(name)
    @name = name
  end
end





# Time.stub(:now).and_return(my_stuff)
